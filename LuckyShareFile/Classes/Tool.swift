//
//  Tool.swift
//  LuckyShareFile
//
//  Created by junky on 2024/5/29.
//

import Foundation
import Social
import UniformTypeIdentifiers
import LuckyException

public struct Tool {
    
    public static func getFileListFrom(context: NSExtensionContext?, compelete: (([URL]) -> Void)?) {
        var target: [URL] = []
        guard let extensionContext = context else { return }
        for (i, obj) in extensionContext.inputItems.enumerated() {
            guard let item = obj as? NSExtensionItem,
                  let attachments = item.attachments as? [NSItemProvider]
            else { continue }
            for (j, provider) in attachments.enumerated() {
                
                _ = provider.loadObject(ofClass: URL.self) { reading, error in
                    if let url = reading {
                        target.append(url)
                    }
                    if i == extensionContext.inputItems.count - 1,
                       j == attachments.count - 1
                    {
                        compelete?(target)
                    }
                }
            }
        }
        compelete?(target)
    }
    
    
    public static func saveFileAndInfo(list: [URL]) {
        // 转换为数据模型
        let file_list: [FileInfo] = list.map { url in
            return FileInfo(originFileUrl: url)
        }
        
        do {
            // 保存文件到沙河
            try file_list.forEach { model in
                var tmp = model
                try tmp.saveToSanbox()
            }
        } catch {
            FileInfo.msg = error.localizedDescription
        }
        // 保存数据到ud
        FileInfo.list.append(contentsOf: file_list)
    }
    
    public static func openContainerApp(context: NSExtensionContext?, from vc: UIViewController) {
        
        guard let url = URL(string: "\(Config.scheme)://shared") else {
            print("can open container app with \(Config.scheme)")
            return
        }
        context?.open(url)
        
        let context = NSExtensionContext()
        context.open(url, completionHandler: nil)
        var responder = vc as UIResponder?
        let selectorOpenURL = sel_registerName("openURL:")
        while (responder != nil) {
            if responder!.responds(to: selectorOpenURL) {
                responder!.perform(selectorOpenURL, with: url)
                break
            }
            responder = responder?.next
        }
    }
    
    
    public static func callInViewDidLoad(context: NSExtensionContext?, from vc: UIViewController) {
        
        getFileListFrom(context: context) { list in
            Tool.saveFileAndInfo(list: list)
            Tool.openContainerApp(context: context, from: vc)
            context?.completeRequest(returningItems: [], completionHandler: nil)
        }
    }
    
}
