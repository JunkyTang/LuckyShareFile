//
//  Config.swift
//  LuckyShareFile
//
//  Created by junky on 2024/5/29.
//

import Foundation
import UniformTypeIdentifiers


public struct Config {
    
    public static var scheme: String = "Lucky"
    
    public static var sanboxDirectory: URL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    
    public static var folderName: String = "share_file"
}
