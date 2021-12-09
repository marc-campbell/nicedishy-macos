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
            let quitItem = NSMenuItem(title: "Quit", action: #selector(onQuit), keyEquivalent: "")
            quitItem.target = self
            menu.addItem(quitItem)
        } else {
            let loginItem = NSMenuItem(title: "Disconnect Dishy", action: #selector(onLogin), keyEquivalent: "")
            loginItem.target = self
            menu.addItem(loginItem)
            menu.addItem(NSMenuItem.separator())
            let pingItem = NSMenuItem(title: "Get Ping", action: #selector(onGetPing), keyEquivalent: "")
            pingItem.target = self
            menu.addItem(pingItem)
            let statusItem = NSMenuItem(title: "Get Status", action: #selector(onGetStatus), keyEquivalent: "")
            statusItem.target = self
            menu.addItem(statusItem)
            let speedTestItem = NSMenuItem(title: "Get SpeedTest", action: #selector(onGetSpeedTest), keyEquivalent: "")
            speedTestItem.target = self
            menu.addItem(speedTestItem)
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
            setupStatusBar()
        }
    }
    
    @objc func onQuit() {
        NSApp.terminate(nil)
    }
    
    var device: Device?
    var isBusy = false
    
    @objc func onGetPing() {
        if isBusy {
            print("Busy. Try later!")
        }
        isBusy = true
        
        let options = GRPCMutableCallOptions()
        options.transport = GRPCDefaultTransportImplList.core_insecure
        device = Device.service(withHost: "192.168.100.1:9200", callOptions: options)
        
        let request = Request()
        request.getPing = GetPingRequest()
        
        let handler = GRPCUnaryResponseHandler<Response>(responseHandler: { [unowned self] (response, error) in
            if error != nil {
                print(error)
            }
            if response != nil {
                print(response)
            }
            isBusy = false
        }, responseDispatchQueue: nil)
        device?.handle(withMessage: request, responseHandler: handler!, callOptions: nil).start()
    }
    
    @objc func onGetStatus() {
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
            payload["state"] = response.dishGetStatus.deviceState
            
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
    
    @objc func onGetSpeedTest() {
        if isBusy {
            print("Busy. Try later!")
        }
        isBusy = true
        
        let options = GRPCMutableCallOptions()
        options.transport = GRPCDefaultTransportImplList.core_insecure
        device = Device.service(withHost: "192.168.100.1:9200", callOptions: options)
        
        let request = Request()
        request.speedTest = SpeedTestRequest()
        device?.handle(with: request, handler: { [unowned self] (response, error) in
            if let err = error {
                print("SpeedTest Error: ")
                print(err)
            } else if let res = response {
                print("SpeedTest Success: ")
                print("\(res.responseOneOfCase)")
            } else {
                print("SpeedTest: no return data")
            }
            
            isBusy = false
        })
    }
}
