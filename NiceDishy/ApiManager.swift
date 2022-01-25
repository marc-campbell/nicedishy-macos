//
//  ApiManager.swift
//  NiceDishy
//
//  Created by Dev on 8/12/21.
//

import Foundation

class ApiManager {
    static let shared = ApiManager()
    
    // production
    static let CONNECT_DISHY_URL = "https://nicedishy.com/connect_device"
    static let PUSH_DATA_URL = "https://api.nicedishy.com/api/v1/stats"
    static let PUSH_SPEED_URL = "https://api.nicedishy.com/api/v1/speed"

//    // local dev
//    static let CONNECT_DISHY_URL = "https://nicedishy-marccampbell.cloud.okteto.net/connect_device"
//    static let PUSH_DATA_URL = "https://nicedishy-api-marccampbell.cloud.okteto.net/api/v1/stats"
//    static let PUSH_SPEED_URL = "https://nicedishy-api-marccampbell.cloud.okteto.net/api/v1/speed"

    static let userAgent = "NiceDishy-Darwin/0.4.0-prerelease"
    
    var dishyToken: String?
    
    func pushSpeed(payload: [String:Any], completionHandler: @escaping (Bool) -> Void) {
        print("pushing speed data: ", payload)
        guard let token = dishyToken, let url = URL(string: ApiManager.PUSH_SPEED_URL) else {
            print("No token")
            completionHandler(false)
            return
        }
        
        if let jsonData = try? JSONSerialization.data(withJSONObject: payload, options: []) {
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.httpBody = jsonData
            request.setValue("Token \(token)", forHTTPHeaderField: "Authorization")
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue(userAgent, forHTTPHeaderField: "User-Agent")
            
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                guard let data = data, error == nil else {
                    print(error?.localizedDescription ?? "No error description")
                    completionHandler(false)
                    return
                }
                
                if let responseData = try? JSONSerialization.jsonObject(with: data, options: []) {
                    if let resObj = responseData as? [String: Any] {
                        print(resObj)
                    }
                    completionHandler(true)
                }
            }
            task.resume()
        }
    }
    
    func pushData(payload: [String:Any], completionHandler: @escaping (Bool) -> Void) {
        print("pushing data: ", payload)

        guard let token = dishyToken, let url = URL(string: ApiManager.PUSH_DATA_URL) else {
            print("No token")
            completionHandler(false)
            return
        }
        
        if let jsonData = try? JSONSerialization.data(withJSONObject: payload, options: []) {
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.httpBody = jsonData
            request.setValue("Token \(token)", forHTTPHeaderField: "Authorization")
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue(userAgent, forHTTPHeaderField: "User-Agent")
            
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                guard let data = data, error == nil else {
                    print(error?.localizedDescription ?? "No error description")
                    completionHandler(false)
                    return
                }
                
                if let responseData = try? JSONSerialization.jsonObject(with: data, options: []) {
                    if let resObj = responseData as? [String: Any] {
                        print(resObj)
                    }
                    completionHandler(true)
                }
            }
            task.resume()
        }
    }
}
