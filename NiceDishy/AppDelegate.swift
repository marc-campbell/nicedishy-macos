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
        // Insert code here to initialize your application
        
        // look for an auth token in keychain
        if let savedToken = KeyChain.load(key: "com.nicedishy.token") {
            let token = savedToken.to(type: String.self)
            ApiManager.shared.dishyToken = token
        }
                
        AppManager.shared.setupStatusBar()
        AppManager.shared.showIconOnDock(false)
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
        
        let data = Data(from: token.value)
        let status = KeyChain.save(key: "com.nicedishy.token", data: data)
        if status != 0 {
            print("failed to write to keychain")
        }
        
        ApiManager.shared.dishyToken = value
        AppManager.shared.setupStatusBar()
    }
}

