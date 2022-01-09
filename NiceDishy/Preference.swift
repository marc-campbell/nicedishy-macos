//
//  Preference.swift
//  NiceDishy
//
//  Created by Dev on 1/9/22.
//

import Foundation

class Preference {
    static let valueChangedNotification = NSNotification.Name("Preference: valueChanged")
    static var db: UserDefaults { return UserDefaults.standard }
    
    static var dataInterval: Int {
        get {
            var sec = db.integer(forKey: "dataInterval")
            
            if sec == 0 {
                sec = 300
            }
            
            return sec
        }
        
        set {
            db.set(newValue, forKey: "dataInterval")
        }
    }
    
    static var speedTestInterval: Int {
        get {
            var sec = db.integer(forKey: "speedTestInterval")
            
            if sec == 0 {
                sec = 3600
            }
            
            return sec
        }
        
        set {
            db.set(newValue, forKey: "speedTestInterval")
        }
    }

}
