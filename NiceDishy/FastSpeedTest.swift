//
//  FastSpeedTest.swift
//  NiceDishy
//
//  Created by Marc Campbell on 1/8/22.
//

import Foundation

enum FastSpeedErrors: Error {
    case failedToFetchToken
    case failedToFetchManifests;
}


// FastSpeedTest is using undocumented methods of grabbing a token
// from fast.com and starting a speed test from it
class FastSpeedTest {
    var token: String?;
    var manifestURLs: [String]?;
    
    private func fetchToken() -> Bool {
        // get the html
        let fastURLString = "https://fast.com";
        guard let fastURL = URL(string: fastURLString) else {
            print("Error: \(fastURLString) doesn't seem to be a valid URL");
            return false;
        }

        var fastHTMLString: String = "";
        do {
            fastHTMLString = try String(contentsOf: fastURL, encoding: .ascii)
        } catch let error {
            print("Error: \(error)")
            return false;
        }

        // find the current js path
        let matched = matches(for: "<script.*\"(/app-[[:xdigit:]]+\\.js)\"", in: fastHTMLString);
        // matched[0] = <script src=\"/app-a32983.js\"
        var matchedComponents = matched[0].components(separatedBy: "/")
        if (matchedComponents.count < 2) {
            print("unable to find js in script tag");
            return false
        }
        
        matchedComponents[1].removeLast();  // trailing "
        let fastJSURLString = "https://fast.com/" + matchedComponents[1];
        
        // get the javascript source
        guard let fastJSURL = URL(string: fastJSURLString) else {
            print("Error: \(fastJSURLString) doesn't seem to be a valid URL");
            return false;
        }

        var fastJSString: String = "";
        do {
            fastJSString = try String(contentsOf: fastJSURL, encoding: .ascii)
        } catch let error {
            print("Error: \(error)")
            return false;
        }

        let tokenMatched = matches(for: "token:[\"']([[:alpha:]]+)['\"]", in: fastJSString);
        var tokenMatchedComppnents = tokenMatched[0].components(separatedBy: ":");
        if (tokenMatchedComppnents.count < 2) {
            print("unable to find token in script");
            return false;
        }
        
        // the token is in quotes, remove
        var token = tokenMatchedComppnents[1];
        token.removeFirst()
        token.removeLast();
        
        self.token = token;
        
        return true;
    }
    
    private func fetchManifests() -> Bool {
        if (self.token == nil) {
            return false;
        }
        
        // eg: "https://api.fast.com/netflix/speedtest/v2?https=true&token=...&urlCount=5"
        let fastManufestsURLString = "https://api.fast.com/netflix/speedtest/v2?https=true&token=" + self.token! + "&urlCount=1";
        guard let fastManifestsURL = URL(string: fastManufestsURLString) else {
            print("Error: \(fastManufestsURLString) doesn't seem to be a valid URL");
            return false;
        }

        var fastManifestsString: String = "";
        do {
            fastManifestsString = try String(contentsOf: fastManifestsURL, encoding: .ascii)
        } catch let error {
            print("Error: \(error)")
            return false;
        }
        
        let json = try? JSONSerialization.jsonObject(with: fastManifestsString.data(using: .utf16)!, options: []);
        if (json == nil) {
            print("error parsing json");
            return false;
        }
        
        let jsonDictionary = json as? [String: Any];
        let targets = jsonDictionary!["targets"]
        
        let targetsArray = targets as? [Any];
        
        var manifestURLs = [String]();
        for target in targetsArray! {
            let targetDictionary = target as? [String: Any];
            let url = targetDictionary!["url"] as? String;
            manifestURLs.append(url!);
            
        }
    
        self.manifestURLs = manifestURLs;
        return true;
    }
    
    public func download(completion: @escaping (Float64?, Error?) -> Void) {
        if (self.token == nil) {
            if (!self.fetchToken()) {
                completion(nil, FastSpeedErrors.failedToFetchToken);
            }
        }
        
        if (self.manifestURLs == nil) {
            if (!self.fetchManifests()) {
                completion(nil, FastSpeedErrors.failedToFetchManifests);
            }
        }
        
        var downloadSizes:[Int] = [4096, 131072, 1048576, 8388608, 33554432];
        var downloadRepeats:[Int] = [0];
        
        var resultTotalSize: Int = 0;
        var resultTotalTime: Float64 = 0;
        var resultsReceived = 0;
        var resultsExpected = downloadSizes.count * downloadRepeats.count * self.manifestURLs!.count;
        
        for downloadSize in downloadSizes {
            for downloadRepeat in downloadRepeats {
                for manifestURLString in self.manifestURLs! {
                    guard let manifestURL = URL(string: manifestURLString) else {
                        print("Error: \(manifestURLString) doesn't seem to be a valid URL");
                        continue;
                    }
                    let chunkURL = manifestURL.appendingPathComponent("/range/0-\(downloadSize)");
                    
                    downloadChunk(url: chunkURL, completion: {(size: Int?, time: Float64?, error: Error?) in
                        if (error != nil) {
                            print(error)
                            return;
                        }
                        
                        resultTotalSize += size!;
                        resultTotalTime += time!;
                        resultsReceived += 1;
                    });
                }
            }
        }
        
        while(true) {
            if (resultsReceived >= resultsExpected) {
                print("received all results (\(resultsReceived) of \(resultsExpected)")
                completion(Float64(resultTotalSize) / resultTotalTime, nil);
                return;
            }
            
            print("recieved \(resultsReceived) of \(resultsExpected) \(resultTotalSize) bytes downloaded so far");
            Thread.sleep(forTimeInterval: 1)
        }
    }
    
    public func downloadChunk(url: URL, completion: @escaping (Int?, Float64?, Error?) -> Void) {
        let documentsUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!

        let destinationUrl = documentsUrl.appendingPathComponent(url.lastPathComponent)

        if FileManager().fileExists(atPath: destinationUrl.path) {
            do {
                try FileManager().removeItem(atPath: destinationUrl.path)
            } catch {
                print("unable to delete file")
            }
        }
        
        let now = Date();
        let session = URLSession(configuration: URLSessionConfiguration.default, delegate: nil, delegateQueue: nil)
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let task = session.dataTask(with: request, completionHandler:
        {
            data, response, error in
            if error == nil
            {
                if let response = response as? HTTPURLResponse
                {
                    if response.statusCode == 200
                    {
                        if let data = data
                        {
                            if let _ = try? data.write(to: destinationUrl, options: Data.WritingOptions.atomic)
                            {
                                let afterDownload = Date();
                                let delta = afterDownload.timeIntervalSince(now);
                                
                                let size = data.count;
                                completion(data.count, delta, error)
                            }
                            else
                            {
                                completion(0, 0, error)
                            }
                        }
                        else
                        {
                            completion(0, 0, error)
                        }
                    }
                }
            }
            else
            {
                completion(0, 0, error)
            }
        })
        task.resume()
    }
    
    public func upload(completion: @escaping (Float64?, Error?) -> Void) {
//        if (self.token == nil) {
//            if (!self.fetchToken()) {
//                completion(nil, FastSpeedErrors.failedToFetchToken);
//            }
//        }
//
        completion(1.0, nil);
    }
    
    func matches(for regex: String, in text: String) -> [String] {
        do {
            let regex = try NSRegularExpression(pattern: regex)
            let results = regex.matches(in: text,
                                        range: NSRange(text.startIndex..., in: text))
            return results.map {
                String(text[Range($0.range, in: text)!])
            }
        } catch let error {
            print("invalid regex: \(error.localizedDescription)")
            return []
        }
    }
}
