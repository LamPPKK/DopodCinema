//
//  RemoteConfigManager.swift
//  DopodCinema
//
//  Created by The Ngoc on 2023/05/11.
//

import Foundation
import FirebaseRemoteConfig

enum RemoteConfigKey: String {
    case timeShowFull = "time_show_full"
}

class RemoteConfigManager {
    
    static let shared = RemoteConfigManager()
    
    private init() {
        loadDefaultValues()
    }
    
    func loadDefaultValues() {
        let appDefaults: [String: Any?] = [
            RemoteConfigKey.timeShowFull.rawValue: 1684729650
        ]
        
        RemoteConfig.remoteConfig().setDefaults(appDefaults as? [String: NSObject])
    }
    
    func activateDebugMode() {
        let settings = RemoteConfigSettings()
        settings.minimumFetchInterval = 6
        RemoteConfig.remoteConfig().configSettings = settings
    }
    
    func fetchCloudValues() {
        activateDebugMode()
        
        RemoteConfig.remoteConfig().fetch { (_, error) in
            if error != nil {
                return
            }
            
            RemoteConfig.remoteConfig().activate { _, _ in
                print("Retrieved values from the cloud!")
            }
        }
    }
    
    func bool(forKey key: RemoteConfigKey) -> Bool {
      RemoteConfig.remoteConfig()[key.rawValue].boolValue
    }

    func string(forKey key: RemoteConfigKey) -> String {
      RemoteConfig.remoteConfig()[key.rawValue].stringValue ?? ""
    }
    
    func double(forKey key: RemoteConfigKey) -> Double {
        let numberValue = RemoteConfig.remoteConfig()[key.rawValue].numberValue
        return numberValue.doubleValue
    }
}
