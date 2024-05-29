//
//  UserDefaultsStorable.swift
//  LuckyUserDefaultsStorable
//
//  Created by junky on 2024/5/28.
//

import Foundation


@propertyWrapper
public struct UserDefaultsStorable<T: Codable> {
    
    public var wrappedValue: T {
        get {
            
            let ud = UserDefaults(suiteName: suitName) ?? .standard
            guard let data = ud.data(forKey: key) else {
                return defaultValue
            }
            let decoder = JSONDecoder()
            guard let decodedValue = try? decoder.decode(T.self, from: data) else {
                return defaultValue
            }
            return decodedValue
        }
        set {
            let ud = UserDefaults(suiteName: suitName) ?? .standard
            let encoder = JSONEncoder()
            if let encodedValue = try? encoder.encode(newValue) {
                ud.set(encodedValue, forKey: key)
            }
        }
    }
    
    let suitName: String?
    
    let key: String
    
    let defaultValue: T
    
    public init(suitName: String? = nil, key: String, defaultValue: T) {
        self.suitName = suitName
        self.key = key
        self.defaultValue = defaultValue
    }
    
}
