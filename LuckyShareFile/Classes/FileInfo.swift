//
//  FileInfo.swift
//  LuckyShareFile
//
//  Created by junky on 2024/5/29.
//

import Foundation
import LuckySanboxStorable
import LuckyUserDefaultsStorable

public class FileInfo: SanboxFileModel, Codable {
    
    public enum FileType: Codable {
        case image
        case txt
        case pdf
        case word
        case ppt
        case excel
        case unknown(String)
        
        static func from(urlExtension: String) -> FileType {
            
            let ext = urlExtension.lowercased()
            if ["png", "jpg", "jpeg"].contains(ext) {
                return .image
            }
            if ["txt"].contains(ext) {
                return txt
            }
            if ["pdf"].contains(ext) {
                return .pdf
            }
            if ["doc"].contains(ext) {
                return .word
            }
            if ["ppt"].contains(ext) {
                return .ppt
            }
            if ["excl"].contains(ext) {
                return .excel
            }
            return .unknown(urlExtension)
        }
        
    }
    
    @UserDefaultsStorable(suitName: Config.groupId, key: "list", defaultValue: [])
    public static var list: [FileInfo]
    
    @UserDefaultsStorable(suitName: Config.groupId, key: "msg", defaultValue: nil)
    public static var msg: String?
    
    
    public var folderName: String {
        return "share_file"
    }
    
    public var originFileUrl: URL
    
    public var sanboxFileName: String?
    
    public var type: FileType
    
    
    public init(originFileUrl: URL, sanboxFileName: String? = nil, type: FileType? = nil) {
        self.originFileUrl = originFileUrl
        self.sanboxFileName = sanboxFileName
        let ext = originFileUrl.pathExtension
        self.type = type ?? FileType.from(urlExtension: ext)
    }
    
}


