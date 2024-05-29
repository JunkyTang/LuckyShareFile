//
//  SanboxStorable.swift
//  LuckySanboxStorable
//
//  Created by junky on 2024/5/28.
//

import Foundation
import LuckyException

public protocol SanboxStorable {}
public extension SanboxStorable {
    
    func storeInSanbox(originPath: URL, directory: URL, folder: String, name: String? = nil) throws -> String {
        
        
        if originPath.startAccessingSecurityScopedResource() {
            defer { originPath.stopAccessingSecurityScopedResource() }
            
            
            var url = directory.appendingPathComponent(folder, isDirectory: true)
            try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true)
            
            let fileName = name ?? UUID().uuidString
            url = url.appendingPathComponent(fileName, isDirectory: false)
            
            if FileManager.default.fileExists(atPath: url.path) {
                try FileManager.default.removeItem(at: url)
            }
            
            try FileManager.default.copyItem(at: originPath, to: url)
            
            return fileName
        }
        throw Exception(msg: "start Accessing Security Scoped Resource failure")
    }
    
    
    func dataInSanbox(directory: URL, folder: String, name: String) throws -> Data {
        
        var url = directory
        url = url.appendingPathComponent(folder, isDirectory: true)
        url = url.appendingPathComponent(name, isDirectory: false)
        let data = try Data(contentsOf: url)
        return data
    }
    
    
}
