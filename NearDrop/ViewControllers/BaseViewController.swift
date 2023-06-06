//
//  BaseViewController.swift
//  NearDrop
//
//  Created by Konstantin Adamov on 6/5/23.
//

import Foundation
import AppKit
class BaseViewController : NSViewController {
    
    func close(){
        self.view.window?.performClose(self)
        GlobalWindowManager.sharedInstance.unregisterWindow(window: self)
    }
}
