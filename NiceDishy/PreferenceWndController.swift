//
//  PreferenceWndController.swift
//  NiceDishy
//
//  Created by Dev on 1/9/22.
//

import Cocoa

class PreferenceWndController: NSWindowController {

    @objc var dataInterval: Int = Preference.dataInterval / 60
    @objc var speedTestInterval: Int = Preference.speedTestInterval / 60
    
    override func windowDidLoad() {
        super.windowDidLoad()

        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
    }
    
    @IBAction func onSave(_ sender: Any) {
        Preference.dataInterval = dataInterval * 60
        Preference.speedTestInterval = speedTestInterval * 60
        
        NotificationCenter.default.post(
            name: Preference.valueChangedNotification,
            object: nil
        )

        close()
    }
    
    @IBAction func onCancel(_ sender: Any) {
        close()
    }
}
