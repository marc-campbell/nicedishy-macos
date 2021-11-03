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
        
        AppManager.shared.setupStatusBar()
        AppManager.shared.showIconOnDock(false)
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}

