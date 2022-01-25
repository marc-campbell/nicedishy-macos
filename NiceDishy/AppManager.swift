//
//  AppManager.swift
//  NiceDishy
//
//  Created by Dev on 29/10/21.
//

import AppKit

class AppManager {
    static let shared = AppManager()
    
    let appStatusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
    let dishyService = DishyService()
    
    let preferenceWinController = PreferenceWndController(windowNibName: "PreferenceWndController")
    
    func setupStatusBar() {
        appStatusItem.button?.title = ""
        appStatusItem.button?.image = NSImage(named: "icon18")
            
        appStatusItem.menu = createMenu()
    }

    var isLoggedIn: Bool {
        (ApiManager.shared.dishyToken != nil)
    }
    
    func createMenu() -> NSMenu {
        let menu = NSMenu()
        if !isLoggedIn {
            let loginItem = NSMenuItem(title: "Connect Dishy", action: #selector(onLogin), keyEquivalent: "")
            loginItem.target = self
            menu.addItem(loginItem)
            
            menu.addItem(NSMenuItem.separator())
            let preferenceItem = NSMenuItem(title: "Preferences", action: #selector(onPreference), keyEquivalent: "")
            preferenceItem.target = self
            menu.addItem(preferenceItem)
            menu.addItem(NSMenuItem.separator())
            
            let quitItem = NSMenuItem(title: "Quit", action: #selector(onQuit), keyEquivalent: "")
            quitItem.target = self
            menu.addItem(quitItem)
        } else {
            menu.addItem(NSMenuItem.separator())
            let preferenceItem = NSMenuItem(title: "Preferences", action: #selector(onPreference), keyEquivalent: "")
            preferenceItem.target = self
            menu.addItem(preferenceItem)
            menu.addItem(NSMenuItem.separator())
            
            let loginItem = NSMenuItem(title: "Disconnect Dishy", action: #selector(onLogin), keyEquivalent: "")
            loginItem.target = self
            menu.addItem(loginItem)
            menu.addItem(NSMenuItem.separator())

            let quitItem = NSMenuItem(title: "Quit", action: #selector(onQuit), keyEquivalent: "")
            quitItem.target = self
            menu.addItem(quitItem)
        }
        return menu
    }
    
    func showIconOnDock(_ flag: Bool) {
        var psn = ProcessSerialNumber(highLongOfPSN: 0, lowLongOfPSN: 2)
        var transformState: ProcessApplicationTransformState
        if flag {
            transformState = ProcessApplicationTransformState(kProcessTransformToForegroundApplication)
        } else {
            transformState = ProcessApplicationTransformState(kProcessTransformToUIElementApplication)
        }
        TransformProcessType(&psn, transformState)
        if (!flag) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                NSApp.activate(ignoringOtherApps: true)
            }
        }
    }
    
    //MARK: - Events
    @objc func onLogin() {
        if !isLoggedIn {
            let url = URL(string: ApiManager.CONNECT_DISHY_URL)!
            if NSWorkspace.shared.open(url) {
                print("Open \(ApiManager.CONNECT_DISHY_URL)")
            }
        } else {
            ApiManager.shared.dishyToken = nil
            DAKeychain.shared.delete(withKey: "com.nicedishy.devicetoken")
            setupStatusBar()
        }
    }
    
    @objc func onPreference() {
        preferenceWinController.showWindow(nil)
        
        NSApp.activate(ignoringOtherApps: true)
    }
    
    @objc func onQuit() {
        NSApp.terminate(nil)
    }
    
    var device: Device?
    var isBusy = false
}
