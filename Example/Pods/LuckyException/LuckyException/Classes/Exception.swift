//
//  LuckyException.swift
//  LuckyToolKit
//
//  Created by junky on 2022/3/2.
//

import Foundation

public struct Exception: Error {
    
    public var msg: String
    
    public var obj: Any?
    
    public init(msg: String, obj: Any? = nil) {
        self.msg = msg
        self.obj = obj
    }
    
    public init(error: Error) {
        self.msg = error.localizedDescription
        self.obj = error
    }
    
}





