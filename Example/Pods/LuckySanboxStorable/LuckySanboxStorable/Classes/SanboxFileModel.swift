//
//  SanboxFileModel.swift
//  LuckySanboxStorable
//
//  Created by junky on 2024/5/28.
//

import Foundation
import LuckyException

public protocol SanboxFileModel: SanboxStorable {
    
    var sanboxDirectory: URL { get }
    
    var folderName: String { get }
    
    var sanboxFileName: String? { set get }
    
    var originFileUrl: URL { get }
}


public extension SanboxFileModel {
    
    var sanboxDirectory: URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    }
    
    var folderName: String {
        return "file"
    }
    
    
    mutating func saveToSanbox() throws {
        let name = try storeInSanbox(originPath: originFileUrl, directory: sanboxDirectory, folder: folderName, name: sanboxFileName)
        sanboxFileName = name
    }
    
    func dataInSanbox() throws -> Data {
        guard let sanboxFileName = sanboxFileName else {
            throw Exception(msg: "Unavailable sanbox file name")
        }
        return try dataInSanbox(directory: sanboxDirectory, folder: folderName, name: sanboxFileName)
    }
    
}


