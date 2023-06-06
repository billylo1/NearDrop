//
//  URLViewPresenter.swift
//  NearDrop
//
//  Created by Konstantin Adamov on 6/4/23.
//

import Foundation
import AppKit

class URLViewPresenter {
    func showPresenter(_ url:URL, remoteDeviceInfo: RemoteDeviceInfo){
        DispatchQueue.main.async {
            
            NSApp.setActivationPolicy(.regular)
            
            let storyboard = NSStoryboard(name: "Storyboard", bundle: nil)
            guard let vc = storyboard.instantiateController(withIdentifier: "urlView") as? NSWindowController else {
                return
            }
            
            NSApp.activate(ignoringOtherApps: true)
            let controller = vc.contentViewController as? URLViewController
            controller?.setURL(url)
            controller?.txtMessage.stringValue = String(format: NSLocalizedString("DeviceSendingUrl", comment: ""), arguments: [remoteDeviceInfo.name])
            
            vc.window?.center()
            vc.window?.makeKeyAndOrderFront(nil)
            
            GlobalWindowManager.sharedInstance.registerWindow(window: controller!)
            
        }
    }
}
