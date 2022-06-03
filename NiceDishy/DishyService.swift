//
//  DishyService.swift
//  NiceDishy
//
//  Created by Marc Campbell on 12/26/21.
//

import Foundation

class DishyService {
    static let shared = DishyService()
    
    private var device = Device.service(withHost: "192.168.100.1:9200", callOptions: nil)
    private var isBusy = false
    private var locker = NSLock()
    private var completionHandlers = [([String: Any]?, Error?) -> Void]()
    
    public static func getAndSendSpeed() {
        // call on a new thread to avoid a deadlock
        Thread.detachNewThread {
            shared.getDishyStatus(completion:{(statusPayload:[String:Any]?, error:Error?) in
                if (error != nil) {
                    print("error retreiving dishy status", error!)
                    return
                }
                
                let now = Date();

                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
                formatter.timeZone = TimeZone(abbreviation: "UTC")

                var payload : [String:Any] = [String:Any]()
                payload["when"] = formatter.string(from:now)
                
                let deviceStatus = statusPayload!["status"] as? [String:Any];
                let deviceInfo = deviceStatus!["deviceInfo"] as? [String:Any];
                
                payload["softwareVersion"] = deviceInfo!["softwareVersion"];
                payload["hardwareVersion"] = deviceInfo!["hardwareVersion"];
                
                var speed : [String:Any] = [String:Any]()
                
                let fastSpeedTest = FastSpeedTest();
                print("starting download test")
                fastSpeedTest.download(completion:{(downloadSpeed:Float64?, error:Error?) in
                    if (error != nil) {
                        print("error retreiving download speed", error!)
                    } else {
                        speed["download"] = downloadSpeed!;
                    }
                    let fastSpeedTestForUpload = FastSpeedTest()
                    print("starting upload test")
                    fastSpeedTestForUpload.upload(completion:{(uploadSpeed:Float64?, error:Error?) in
                        if (error != nil) {
                            print("error retreiving upload speed", error!);
                        } else {
                            speed["upload"] = uploadSpeed;
                        }
                        
                        payload["speed"] = speed;
                        
                        print("sending speed data")
                        ApiManager.shared.pushSpeed(payload: payload) { pushResult in
                            print("push speed complete")
                        }
                    });
                });
            });
        }
    }
    
    public static func getAndSendData() {
        // call on a new thread to avoid a deadlock
        Thread.detachNewThread {
            shared.getDishyStatus(completion:{(payload:[String:Any]?, error:Error?) in
                if (error != nil) {
                    print("error retreiving dishy status", error!)
                    return
                }

                ApiManager.shared.pushData(payload: payload!) { pushResult in
                    print("push data complete")
                }
            });
        }
    }
    
    public func getDishyStatus(completion: @escaping ([String:Any]?, Error?) -> Void) {
        // register completion handler
        locker.lock()
        completionHandlers.append(completion)
        locker.unlock()
        
        if isBusy {
            return
        }
        
        isBusy = true
        
        // status request
        let request = Request()
        request.getStatus = GetStatusRequest()

        // call option
        let options = GRPCMutableCallOptions()
        options.transport = GRPCDefaultTransportImplList.core_insecure
        
        // call service
        if let handler = GRPCUnaryResponseHandler<Response>(responseHandler: { [unowned self] (response, error: Error?) in
            isBusy = false

            if error != nil {
                print(error!)
                onCompleted(payload: nil, error: error)
                return
            }

            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
            formatter.timeZone = TimeZone(abbreviation: "UTC")

            var deviceInfo : [String:Any] = [String:Any]()
            deviceInfo["hardwareVersion"] = response.dishGetStatus.deviceInfo.hardwareVersion!
            deviceInfo["softwareVersion"] = response.dishGetStatus.deviceInfo.softwareVersion!

            var deviceState : [String:Any] = [String:Any]()
            deviceState["uptimeSeconds"] = response.dishGetStatus.deviceState.uptimeS

            var status : [String:Any] = [String:Any]()

            status["deviceInfo"] = deviceInfo
            status["deviceState"] = deviceState

            status["snr"] = 0; // TODO
            status["downlinkThroughputBps"] = response.dishGetStatus.downlinkThroughputBps
            status["uplinkThroughputBps"] = response.dishGetStatus.uplinkThroughputBps
            status["popPingLatencyMs"] = response.dishGetStatus.popPingLatencyMs
            status["popPingDropRate"] = response.dishGetStatus.popPingDropRate
            status["percentObstructed"] = 0 // TODO
            status["secondsObstructed"] = 0;  // TODO

            var payload : [String:Any] = [String:Any]()
            payload["when"] = formatter.string(from: Date())
            payload["status"] = status

            onCompleted(payload: payload, error: nil)
            
        }, responseDispatchQueue: DispatchQueue.main) {
            let req = device.handle(withMessage: request, responseHandler: handler, callOptions: options)
            req.start()
        }
    }
    
    func onCompleted(payload: [String: Any]?, error: Error?) {
        locker.lock()
        for c in completionHandlers {
            c(payload, error)
        }
        completionHandlers.removeAll()
        locker.unlock()
    }
}

