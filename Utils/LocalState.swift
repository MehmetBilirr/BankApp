//
//  LocalState.swift
//  BankApp
//
//  Created by Mehmet Bilir on 22.06.2022.
//

import Foundation

public class LocalState {
    
    private enum Keys:String {
        case hasOnboarded
        case hasLoggedin
        
    }
    
    public static var hasOnboarded : Bool {
        get {
            return UserDefaults.standard.bool(forKey: Keys.hasOnboarded.rawValue)
        }
        set (newValue) {
            UserDefaults.standard.set(newValue, forKey: Keys.hasOnboarded.rawValue)
            UserDefaults.standard.synchronize()
            
        }
    }
    
    public static var hasLoggedin: Bool {
        get {
            return UserDefaults.standard.bool(forKey: Keys.hasLoggedin.rawValue)
        }
        set (newValue) {
            UserDefaults.standard.set(newValue, forKey: Keys.hasLoggedin.rawValue)
            UserDefaults.standard.synchronize()
        }
    }
    
    
    
    
}
