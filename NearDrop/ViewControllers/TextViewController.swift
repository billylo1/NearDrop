//
//  TextViewController.swift
//  NearDrop
//
//  Created by Konstantin Adamov on 6/4/23.
//

import Foundation
import AppKit


class TextViewController : NSViewController {
    
    var text:String = ""
    
    @IBOutlet weak var txtMessage: NSTextField!
    
    @IBOutlet weak var txtText: NSTextField!
    
    @IBAction func onCancelClick(_ sender: Any) {
        close()
    }
    
    @IBAction func onCopyClick(_ sender: Any) {
        NSPasteboard.general.clearContents()
        NSPasteboard.general.setString(text, forType: .string)
        close()
    }
    
    @IBAction func onSaveAsClick(_ sender: Any) {
        let savePanel = NSSavePanel()
        savePanel.canCreateDirectories = true
        savePanel.showsTagField = false
        savePanel.nameFieldStringValue = "shared text.txt"
        savePanel.level = NSWindow.Level(rawValue: Int(CGWindowLevelForKey(.modalPanelWindow)))
        
        if (savePanel.runModal() == .OK){
            if let result = savePanel.url {
                do {
                    try text.write(to: result, atomically: true, encoding: String.Encoding.utf8)
                } catch {
                    
                }
            }
        }
        
        close()
    }
    
    private func close(){
        NSApp.setActivationPolicy(.accessory)
        self.view.window?.performClose(self)
    }
    
    func setText(_ text:String) {
        self.text = text
        
        txtText.stringValue = self.text
        
    }
}
