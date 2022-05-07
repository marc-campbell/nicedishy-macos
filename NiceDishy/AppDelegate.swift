//
//  AppDelegate.swift
//  NiceDishy
//
//  Created by Dev on 14/10/21.
//

import Cocoa
import Sentry

@main
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet var window: NSWindow!
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        SentrySDK.start { options in
            options.dsn = "https://486195828d83439c9f7710e68a00d106@o242537.ingest.sentry.io/6209419"
            options.debug = true // Enabled debug when first installing is always helpful

            // Set tracesSampleRate to 1.0 to capture 100% of transactions for performance monitoring.
            // We recommend adjusting this value in production.
            options.tracesSampleRate = 1.0
        }
        
        // look for an auth token in keychain
        let token = DAKeychain.shared["com.nicedishy.devicetoken"]
        ApiManager.shared.dishyToken = token;
        
        AppManager.shared.setupStatusBar()
        AppManager.shared.showIconOnDock(false)
                
        createSpeedTestTimer()
        createDataTimer()
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.preferenceChanged),
            name: Preference.valueChangedNotification,
            object: nil
        )
    }

    func testFastSpeed() {
        let downFastSpeedTest = FastSpeedTest()
        print("starting download test")
        downFastSpeedTest.timeout = 15
        downFastSpeedTest.download(completion:{(downloadSpeed:Float64?, error:Error?) in
            if let dspeed = downloadSpeed {
                print("Download Speed---------------------\(Int(dspeed/1024/1024)) Mbps")
            }
            let upFastSpeedTest = FastSpeedTest()
            upFastSpeedTest.timeout = 15
            upFastSpeedTest.upload(completion:{(uploadSpeed:Float64?, error:Error?) in
                if let uspeed = uploadSpeed {
                    print("Upload Speed---------------------\(Int(uspeed/1024/1024)) Mbps")
                }
            })
        })
    }
    
    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    // callback for when nicedishy:// urls are opened
    func application(_ application: NSApplication, open urls: [URL]) {
        print("application open nicedishy:// url");
        
        guard let url = urls.first, let host = url.host, host == "connected" else {
            return
        }
        
        guard let components = URLComponents(url: url, resolvingAgainstBaseURL: true),
              let queryItems = components.queryItems else {
            return
        }
        
        guard let token = queryItems.first(where: { $0.name == "token" }),
              let value = token.value else {
            return
        }
        
        DAKeychain.shared["com.nicedishy.devicetoken"] = value;
        
        ApiManager.shared.dishyToken = value
        AppManager.shared.setupStatusBar()
        
        DishyService.getAndSendData()
        DishyService.getAndSendSpeed()
    }
    
    // MARK: - Timer & Notification

    var speedTestTimer: Timer?
    var dataTimer: Timer?
    
    func createSpeedTestTimer() {
        // the timer is the main data collection method...
        
        // if we are logged in, send data immediately
        if (ApiManager.shared.dishyToken != nil) {
            DishyService.getAndSendData()
            DishyService.getAndSendSpeed()
        }

        speedTestTimer = Timer.scheduledTimer(
            timeInterval: Double(Preference.speedTestInterval),
            target: self,
            selector: #selector(self.pollIntervalWithSpeedTest),
            userInfo: nil,
            repeats: true
        )
    }
    
    func createDataTimer() {
        dataTimer = Timer.scheduledTimer(
            timeInterval: Double(Preference.dataInterval),
            target: self,
            selector: #selector(self.pollIntervalWithoutSpeedTest),
            userInfo: nil,
            repeats: true
        )
    }

    // pollIntervalWithSpeedTest is called on an inteval and should handle collecting and sending data to the api
    // this will be called even if not logged in
    @objc func pollIntervalWithSpeedTest() {
        // if logged in, get and send data
        if (ApiManager.shared.dishyToken == nil) {
            print("not logged in")
            return
        }

        print("getting and sending speed")
        DishyService.getAndSendSpeed()
    }
    
    // pollIntervalWithoutSpeedTest is called on an inteval and should handle collecting and sending data to the api
    // this will be called even if not logged in
    @objc func pollIntervalWithoutSpeedTest() {
        // if logged in, get and send data
        if (ApiManager.shared.dishyToken == nil) {
            print("not logged in")
            return
        }
        
        print("getting and sending data")
        DishyService.getAndSendData()
    }

    @objc func preferenceChanged(_ n: Notification) {
        if let t = speedTestTimer {
            t.invalidate()
            createSpeedTestTimer()
        }
        
        if let t = dataTimer {
            t.invalidate()
            createDataTimer()
        }
    }
}

