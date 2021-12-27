//
//  AppDelegate.swift
//  NiceDishy
//
//  Created by Dev on 14/10/21.
//

import Cocoa

@main
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet var window: NSWindow!
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // look for an auth token in keychain
        let token = DAKeychain.shared["com.nicedishy.token"]
        ApiManager.shared.dishyToken = token;
        
        AppManager.shared.setupStatusBar()
        AppManager.shared.showIconOnDock(false)
        
        // if we are logged in, send data immediately
        if (ApiManager.shared.dishyToken != nil) {
            AppManager.shared.dishyService.getData()
        }
        
        // the timer is the main data collection method...
        let interval = 60.0 * 5
        Timer.scheduledTimer(timeInterval: interval, target: self, selector: #selector(self.pollInterval), userInfo: nil, repeats: true)
    }
    
    // pollInterval is called on an inteval and should handle collecting and sending data to the api
    // this will be called even if not logged in
    @objc func pollInterval() {
        // if logged in, get and send data
        if (ApiManager.shared.dishyToken == nil) {
            print("not logged in")
            return
        }
        
        print("getting and sending data")
        AppManager.shared.dishyService.getData()
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    func application(_ application: NSApplication, open urls: [URL]) {
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
        
        DAKeychain.shared["com.nicedishy.token"] = value;
        
        ApiManager.shared.dishyToken = value
        AppManager.shared.setupStatusBar()
        
        AppManager.shared.dishyService.getData()
    }
}

