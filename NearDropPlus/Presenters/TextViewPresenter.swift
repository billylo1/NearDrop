//
//  TextViewPresenter.swift
//  NearDrop
//
//  Created by Konstantin Adamov on 6/4/23.
//

import Foundation
import AppKit

// Wrapper to show accepted text and allow user to copy, save as file or cancel
class TextViewPresenter {
    func showPresenter(_ text:String, remoteDeviceInfo: RemoteDeviceInfo){
        DispatchQueue.main.async {
            
            NSApp.setActivationPolicy(.regular)
            
            let storyboard = NSStoryboard(name: "Storyboard", bundle: nil)
            guard let vc = storyboard.instantiateController(withIdentifier: "textView") as? NSWindowController else {
                return
            }
            
            NSApp.activate(ignoringOtherApps: true)
            let controller = vc.contentViewController as? TextViewController
            controller?.setText(text)
            controller?.txtMessage.stringValue = String(format: NSLocalizedString("DeviceSendingText", comment: ""), arguments: [remoteDeviceInfo.name])
            
            
            vc.window?.center()
            vc.window?.makeKeyAndOrderFront(nil)
            
            GlobalWindowManager.sharedInstance.registerWindow(window: controller!)
            
        }
    }
}
