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

            var deviceInfo : [String:Any] = [String:Any]()
            deviceInfo["hardwareVersion"] = response.dishGetStatus.deviceInfo.hardwareVersion!
            deviceInfo["softwareVersion"] = response.dishGetStatus.deviceInfo.softwareVersion!
            
            var deviceState : [String:Any] = [String:Any]()
            deviceState["uptimeSeconds"] = response.dishGetStatus.deviceState.uptimeS
            
            var payload : [String:Any] = [String:Any]()
            payload["deviceInfo"] = deviceInfo
            payload["deviceState"] = deviceState

            payload["state"] = "??"
            payload["snr"] = 0;
            payload["downlinkThroughputBps"] = response.dishGetStatus.downlinkThroughputBps
            payload["uplinkThroughputBps"] = response.dishGetStatus.uplinkThroughputBps
            payload["popPingLatencyMs"] = response.dishGetStatus.popPingLatencyMs
            payload["popPingDropRate"] = response.dishGetStatus.popPingDropRate
            payload["percentObstructed"] = 0
            payload["secondsObstructed"] = 0;
            
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: payload, options: [])
                let jsonString = String(data: jsonData, encoding: String.Encoding.ascii)!
            
                print(jsonString)
            } catch {
                print("JSON Serialization error: ", error)
            }
        }, responseDispatchQueue: nil)
        device?.handle(withMessage: request, responseHandler: handler!, callOptions: nil).start()
    }
}

