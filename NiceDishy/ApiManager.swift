//
//  ApiManager.swift
//  NiceDishy
//
//  Created by Dev on 8/12/21.
//

import Foundation

class ApiManager {
    static let shared = ApiManager()
    
    static let CONNECT_DISHY_URL = "https://nicedishy.com/connect_device"
    static let PUSH_DATA_URL = "https://nicedishy.com/"
    
    var dishyToken: String?
    
    func push(data: [String: Any], completionHandler: @escaping (Bool) -> Void) {
        guard let token = dishyToken, let url = URL(string: ApiManager.PUSH_DATA_URL) else {
            print("No token")
            completionHandler(false)
            return
        }
        
        if let jsonData = try? JSONSerialization.data(withJSONObject: data, options: []) {
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.httpBody = jsonData
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            // request.addValue("application/json", forHTTPHeaderField: "Accept")
            // request.addValue("\(jsonData.count)", forHTTPHeaderField: "Content-Length")
            
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
