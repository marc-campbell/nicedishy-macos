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
    
    public func getSpeed() {
        let now = Date();
        let url = URL(string: "https://speed.nicedishy.com/130mb")
        FileDownloader.loadFileAsync(url: url!, completion:{(path:String?, error:Error?) in
            print("received download speed data")
            let afterDownload = Date()
            let delta = afterDownload.timeIntervalSince(now);
            
            let fileSize = 136314880.0 * 8
            let downloadSpeed = fileSize / delta
            
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
            
            var speed : [String:Any] = [String:Any]()
            speed["download"] = downloadSpeed
            
            var payload : [String:Any] = [String:Any]()
            payload["when"] = formatter.string(from:now)
            payload["speed"] = speed
            
            do {
                ApiManager.shared.pushSpeed(payload: payload) { pushResult in
                    print("push complete")
                }
            } catch {
                print("JSON Serialization error: ", error)
            }
        })
    }
    
    public func getData() {
        if isBusy {
            print("Busy. Try later!")
        }
        isBusy = true
        
        let options = GRPCMutableCallOptions()
        options.transport = GRPCDefaultTransportImplList.core_insecure
        device = Device.service(withHost: "192.168.100.1:9200", callOptions: options)
        
        let now = Date();

        let request = Request()
        request.getStatus = GetStatusRequest()
        let handler = GRPCUnaryResponseHandler<Response>(responseHandler: { [unowned self] (response, error) in
            isBusy = false
            
            if error != nil {
                print(error)
                return
            }
                        
            var formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
            
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
            
            do {
                ApiManager.shared.pushData(payload: payload) { pushResult in
                    print("push complete")
                }
            } catch {
                print("JSON Serialization error: ", error)
            }
        }, responseDispatchQueue: nil)
        device?.handle(withMessage: request, responseHandler: handler!, callOptions: nil).start()
    }
}

