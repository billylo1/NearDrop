//
//  URLViewController.swift
//  NearDrop
//
//  Created by Konstantin Adamov on 6/4/23.
//

import Foundation
import AppKit

class URLViewController : BaseViewController {
    
    var url : URL?
    @IBOutlet weak var txtURL: NSTextField!
    @IBOutlet weak var txtMessage: NSTextField!
    
    
    func setURL(_ url:URL) {
        self.url = url
        
        txtURL.stringValue = self.url!.absoluteString
        
    }
    @IBAction func onOpenClick(_ sender: Any) {
        
        NSWorkspace.shared.open(url!)
        
        close()
    }
    
    @IBAction func onCancelClick(_ sender: Any) {
        close()
    }
    
    @IBAction func onCopyCLick(_ sender: Any) {
        NSPasteboard.general.clearContents()
        NSPasteboard.general.setString(url!.absoluteString, forType: .string)
        close()
    }
    
    
    
}
