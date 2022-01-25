//
//  FastSpeedTest.swift
//  NiceDishy
//
//  Created by Marc Campbell on 1/8/22.
//

import Foundation

enum FastSpeedErrors: Error {
    case failedToFetchToken
    case failedToFetchManifests
    case notReceived200
    case failedToUpload
    case failedToGenerateData
}


// FastSpeedTest is using undocumented methods of grabbing a token
// from fast.com and starting a speed test from it
class FastSpeedTest {
    var fastServerCount: Int = 5
    // cause timeout after 10 sec
    var timeout: Double = 10
    var payloadSizes = [2048, 26214400]
    
    private var token: String?
    private var targetURLs = [String]()
    private var requesters: [Requester] = []
    private var timestamp: Double = 0
    
    private func fetchToken() -> Bool {
        // get the html
        let fastURLString = "https://fast.com"
        guard let fastURL = URL(string: fastURLString) else {
            print("Error: \(fastURLString) doesn't seem to be a valid URL")
            return false
        }

        var fastHTMLString: String = ""
        do {
            fastHTMLString = try String(contentsOf: fastURL, encoding: .ascii)
        } catch let error {
            print("Error: \(error)")
            return false
        }

        // find the current js path
        let matched = matches(for: "<script.*\"(/app-[[:xdigit:]]+\\.js)\"", in: fastHTMLString)
        // matched[0] = <script src=\"/app-a32983.js\"
        var matchedComponents = matched[0].components(separatedBy: "/")
        if matchedComponents.count < 2 {
            print("unable to find js in script tag")
            return false
        }
        
        matchedComponents[1].removeLast()  // trailing "
        let fastJSURLString = "https://fast.com/" + matchedComponents[1]
        
        // get the javascript source
        guard let fastJSURL = URL(string: fastJSURLString) else {
            print("Error: \(fastJSURLString) doesn't seem to be a valid URL")
            return false
        }

        var fastJSString: String = ""
        do {
            fastJSString = try String(contentsOf: fastJSURL, encoding: .ascii)
        } catch let error {
            print("Error: \(error)")
            return false
        }

        let tokenMatched = matches(for: "token:[\"']([[:alpha:]]+)['\"]", in: fastJSString)
        let tokenMatchedComponents = tokenMatched[0].components(separatedBy: ":")
        if tokenMatchedComponents.count < 2 {
            print("unable to find token in script")
            return false
        }
        
        // the token is in quotes, remove
        var token = tokenMatchedComponents[1]
        token.removeFirst()
        token.removeLast()
        
        self.token = token
        
        return true
    }
    private func fetchTargets() {
        targetURLs.removeAll()

        guard token != nil else {
            return
        }
        
        // eg: "https://api.fast.com/netflix/speedtest/v2?https=true&token=...&urlCount=5"
        let fastTargetURLString = "https://api.fast.com/netflix/speedtest/v2?https=true&token=" + self.token! + "&urlCount=\(fastServerCount)"
        guard let fastTargetURL = URL(string: fastTargetURLString) else {
            print("Error: \(fastTargetURLString) doesn't seem to be a valid URL")
            return
        }

        var fastTargetContent: String = ""
        do {
            fastTargetContent = try String(contentsOf: fastTargetURL, encoding: .ascii)
        } catch let error {
            print("Error: \(error)")
            return
        }
        
        let json = try? JSONSerialization.jsonObject(with: fastTargetContent.data(using: .utf16)!, options: [])
        if json == nil {
            print("error parsing json")
            return
        }
        
        let jsonDictionary = json as? [String: Any]
        let targets = jsonDictionary!["targets"]
        
        let targetsArray = targets as? [Any]
        
        var targetURLs = [String]()
        for target in targetsArray! {
            let targetDictionary = target as? [String: Any]
            let url = targetDictionary!["url"] as? String
            targetURLs.append(url!)
        }
    
        self.targetURLs = targetURLs
    }
    
    func download(completion: @escaping (Float64?, Error?) -> Void) {
        makeRequests(isDownload: true, completion: completion)
    }
    
    func upload(completion: @escaping (Float64?, Error?) -> Void) {
        makeRequests(isDownload: false, completion: completion)
    }
    
    func makeRequests(isDownload: Bool, completion: @escaping (Float64?, Error?) -> Void) {
        Thread.detachNewThread { [unowned self] in
            // Fetch Token
            if token == nil {
                if !fetchToken() {
                    completion(nil, FastSpeedErrors.failedToFetchToken);
                    return
                }
            }
            
            // Fetch Targets
            fetchTargets()
            if targetURLs.isEmpty {
                completion(nil, FastSpeedErrors.failedToFetchManifests)
                return
            }
            
            requesters.removeAll()
            
            for urlString in targetURLs {
                guard let url = URL(string: urlString) else {
                    print("Error: \(urlString) doesn't seem to be a valid URL");
                    continue;
                }
                
                let numReq = Int.random(in: 3..<9)
                
                for _ in 0..<numReq {
                    
                    let size = payloadSizes[Int.random(in: 0..<payloadSizes.count)]
                    
                    let chunkURL = url.appendingPathComponent("/range/0-\(size)");
                    
                    let req = Requester(
                        rt: (isDownload ? .download : .upload),
                        sz: size,
                        url: chunkURL.absoluteString)
                    req.start()
                    requesters.append(req)
                }
            }
            
            timestamp = Date().timeIntervalSince1970
            DispatchQueue.main.async {
                Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
                    print("Speed: \(Int(speed)/1024) kbps")
                    if Date().timeIntervalSince1970 - timestamp > timeout {
                        timer.invalidate()
                        cancelRequests()
                        completion(Float64(speed), nil)
                    }
                }
            }
        }
    }
    
    private func cancelRequests() {
        for req in requesters {
            if !req.isCompleted {
                req.stop()
            }
        }
    }
    
    var speed: Double {
        get {
            if requesters.isEmpty {
                return 0
            }
            
            var sum: Double = 0
            for req in requesters {
                sum += req.averageSpeed
            }
            return sum / Double(requesters.count)
        }
    }
    
    private func matches(for regex: String, in text: String) -> [String] {
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

class Requester : NSObject, URLSessionDataDelegate {
    enum ReqType {
        case download
        case upload
    }
    
    var reqType: ReqType = .download
    var reqIndx: Int = 0
    var reqSize: Double = 0
    var reqURL: URL?
    var startTime: Double = 0
    
    init(rt: ReqType, sz: Int, url: String) {
        reqType = rt
        reqSize = Double(sz)
        reqURL = URL(string: url)
    }

    var dataTask: URLSessionDataTask?
    
    var isCompleted: Bool {
        get {
            guard let task = dataTask else { return false }
            return task.state == .completed
        }
    }
    
    static let pieceCount = 20
    var pieceIndex = 0
    var pieceSpeed = [Double](repeating: -1, count: pieceCount)
    
    var averageSpeed: Double {
        get {
            var sum: Double = 0
            var cnt: Double = 0
            for ps in pieceSpeed {
                if ps < 0 {
                    continue
                }
                sum += ps
                cnt += 1
            }
            if cnt > 0 {
                return sum / cnt
            }
            return 0
        }
    }
    
    func start() {
        guard reqURL != nil else {
            return
        }

        pieceIndex = 0
        pieceSpeed = [Double](repeating: -1, count: Requester.pieceCount)
        
        startTime = Date().timeIntervalSince1970
        
        if reqType == .download {
            download()
        } else {
            upload()
        }
    }
    
    func stop() {
        if let task = dataTask, task.state != .completed {
            task.cancel()
        }
    }
    
    func download() {
        let session = URLSession(configuration: URLSessionConfiguration.default, delegate: self, delegateQueue: nil)
        var request = URLRequest(url: reqURL!)
        request.httpMethod = "GET"
        dataTask = session.dataTask(with: request)
        dataTask?.resume()
    }
    
    func upload() {
        let session = URLSession(configuration: URLSessionConfiguration.default, delegate: self, delegateQueue: nil)
        var request = URLRequest(url: reqURL!)
        request.httpMethod = "POST"

        var keyData = Data(count: Int(reqSize))
        let result = keyData.withUnsafeMutableBytes {
            SecRandomCopyBytes(kSecRandomDefault, Int(reqSize), $0.baseAddress!)
        }
        if result == errSecSuccess {
            request.httpBody = keyData
        } else {
            print("Problem generating random bytes")
        }

        dataTask = session.dataTask(with: request)
        dataTask?.resume()
    }
    
    func addPieceSpeed(_ bytes: Int64) {
        let curTm = Date().timeIntervalSince1970
        let delta = curTm - startTime
        let dSize = Double(bytes)
        let speed = dSize * 8 / delta
        
        pieceSpeed[pieceIndex] = speed
        pieceIndex = (pieceIndex + 1) % Requester.pieceCount
        startTime = curTm
    }
    
    //MARK: - URLSessionTaskDelegate
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        if let err = error {
            print("Connection Error: \(err.localizedDescription)")
        } else {
            print("Connection finished")
        }
    }
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        if reqType == .download {
            //print("received bytes: \(dataTask.countOfBytesReceived/1024) kb")
            //addPieceSpeed(Int64(dataTask.countOfBytesReceived))
            //print("received bytes: \(data.count/1024) KB")
            addPieceSpeed(Int64(data.count))
        }
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didSendBodyData bytesSent: Int64, totalBytesSent: Int64, totalBytesExpectedToSend: Int64) {
        if reqType == .upload {
            //print("sent bytes: \(totalBytesSent/1024) KB")
            addPieceSpeed(bytesSent)
        }
    }
}
