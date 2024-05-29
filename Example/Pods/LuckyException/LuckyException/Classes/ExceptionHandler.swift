//
//  ExceptionHandler.swift
//  LuckyException
//
//  Created by junky on 2024/5/25.
//

import Foundation


open class ExceptionHandler {
    
    
    public static let shared = ExceptionHandler()
    
    /// 统一异常处理
    /// - Parameter throwable: 可抛异常的操作
    public func handler(_ throwable: () throws -> Void) {
        do {
            try throwable()
        }
        catch {
            catchException(error)
        }
    }
    
    
    /// 捕获到异常时处理，按需设置
    public var catchException: (Error) -> Void = { err in
        
    }
    
}
