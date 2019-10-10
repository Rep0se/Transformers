//
//  UserDefaults+Extension.swift
//  Transformers
//
//  Created by Alexander Sundiev on 2019-10-10.
//  Copyright © 2019 Alexander Sundiev. All rights reserved.
//

import Foundation

extension UserDefaults {
    
    enum UserDefaultsKeys: String {
        case appLaunched
        case apiKey
    }
    
    /**
     A setter for appLaunched flag in UserDefaults.
     - Parameter value: Bool value.
     */
    func setAppLaunched(value: Bool) {
        set(value, forKey: UserDefaultsKeys.appLaunched.rawValue)
        synchronize()
    }
    
    /**
     A getter for hasLaunchedApp flag in UserDefaults.
     - Returns: Bool value.
     */
    func appLaunched() -> Bool {
        return bool(forKey: UserDefaultsKeys.appLaunched.rawValue)
    }
    
    /**
     A setter for apiKey in UserDefaults.
     - Parameter value: String value.
     */
    func setApiKey(value: String) {
        set(value, forKey: UserDefaultsKeys.apiKey.rawValue)
        synchronize()
    }
    
    /**
     A getter for apiKey in UserDefaults.
     - Returns: String value.
     */
    func apiKey() -> String {
        return UserDefaults.standard.string(forKey: UserDefaultsKeys.apiKey.rawValue) ?? ""
    }
}
