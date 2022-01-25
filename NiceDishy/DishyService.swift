//
//  DishyService.swift
//  NiceDishy
//
//  Created by Marc Campbell on 12/26/21.
//

import Foundation

class DishyService {
    var device: Device?
    var isBusy = false
    
    public func getAndSendSpeed() {
        getDishyStatus(completion:{(statusPayload:[String:Any]?, error:Error?) in
            if (error != nil) {
                print("error retreiving dishy status", error!)
                return
            }
            
            DispatchQueue.global(qos: .userInitiated).async {
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
                    print("starting upload test")
                    fastSpeedTest.upload(completion:{(uploadSpeed:Float64?, error:Error?) in
                        if (error != nil) {
                            print("error retreiving upload speed", error!);
                        } else {
                            speed["upload"] = uploadSpeed;
                        }
                        
                        payload["speed"] = speed;
                        
                        print("sending speed data")
                        ApiManager.shared.pushSpeed(payload: payload) { pushResult in
                            print("push complete")
                        }
                    });
                });
            }
        });
    }
    
    public func getDishyStatus(completion: @escaping ([String:Any], Error?) -> Void) {
        DispatchQueue.global(qos: .userInitiated).async {
            if self.isBusy {
                print("Busy. Try later!")
            }
            self.isBusy = true
            
            let options = GRPCMutableCallOptions()
            options.transport = GRPCDefaultTransportImplList.core_insecure
            self.device = Device.service(withHost: "192.168.100.1:9200", callOptions: options)
            
            let now = Date();

            let request = Request()
            request.getStatus = GetStatusRequest()
            let handler = GRPCUnaryResponseHandler<Response>(responseHandler: { [unowned self] (response, error: Error?) in
                isBusy = false
                
                if error != nil {
                    print(error!)
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
                payload["when"] = formatter.string(from:now)
                payload["status"] = status
                
                
                completion(payload, nil);
            }, responseDispatchQueue: nil)
            self.device?.handle(withMessage: request, responseHandler: handler!, callOptions: nil).start()
        }
    }
    
    public func getAndSendData() {
        
        getDishyStatus(completion:{(payload:[String:Any]?, error:Error?) in
            if (error != nil) {
                print("error retreiving dishy status", error!)
                return
            }
            
            ApiManager.shared.pushData(payload: payload!) { pushResult in
                print("push complete")
            }
        });
    }
}

