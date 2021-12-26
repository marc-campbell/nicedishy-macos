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
    
    public func getData() {
        if isBusy {
            print("Busy. Try later!")
        }
        isBusy = true
        
        let options = GRPCMutableCallOptions()
        options.transport = GRPCDefaultTransportImplList.core_insecure
        device = Device.service(withHost: "192.168.100.1:9200", callOptions: options)
        
        let request = Request()
        request.getStatus = GetStatusRequest()
        let handler = GRPCUnaryResponseHandler<Response>(responseHandler: { [unowned self] (response, error) in
            isBusy = false

            if error != nil {
                print(error)
                return
            }
            
            let now = Date();
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
            
            status["state"] = "??"
            status["snr"] = 0;
            status["downlinkThroughputBps"] = response.dishGetStatus.downlinkThroughputBps
            status["uplinkThroughputBps"] = response.dishGetStatus.uplinkThroughputBps
            status["popPingLatencyMs"] = response.dishGetStatus.popPingLatencyMs
            status["popPingDropRate"] = response.dishGetStatus.popPingDropRate
            status["percentObstructed"] = 0
            status["secondsObstructed"] = 0;
            
            var payload : [String:Any] = [String:Any]()
            payload["when"] = formatter.string(from:now)
            payload["status"] = status
            
            
            do {
                ApiManager.shared.push(payload: payload) { pushResult in
                    print("push complete")
                }
            } catch {
                print("JSON Serialization error: ", error)
            }
        }, responseDispatchQueue: nil)
        device?.handle(withMessage: request, responseHandler: handler!, callOptions: nil).start()
    }
}

