//
//  GlobalWindowManager.swift
//  NearDrop
//
//  Created by Konstantin Adamov on 6/5/23.
//

import Foundation
import AppKit

/*
 Class holds reference to opened Windows and when last windo closed calls NSApp.setActivationPolicy(.accessory)
 */
class GlobalWindowManager {
    static let sharedInstance: GlobalWindowManager = GlobalWindowManager()
    
    let queue = DispatchQueue(label: "thread-safe-array")
    
    var allWindows = [NSViewController]()
    
    func registerWindow(window : NSViewController){
        queue.async { [self] in
            allWindows.append(window)
        }
    }
    
    func unregisterWindow(window : NSViewController){
        queue.sync {
            if let index = allWindows.firstIndex(of: window) {
                allWindows.remove(at: index)
                
                if allWindows.isEmpty {
                    NSApp.setActivationPolicy(.accessory)
                }
            }
        }
    }
}
