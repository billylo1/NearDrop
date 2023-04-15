//
//  PreferencesViewController.swift
//  NearDrop
//
//  Created by XRayAdamo on 4/14/23.
//

import Cocoa

class PreferencesViewController: NSViewController {

    private let settings = AppSettings.sharedInstance
    
    @IBOutlet weak var txtComputerName: NSTextField!
    @IBOutlet weak var cbAlertType: NSComboBox!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        cbAlertType.selectItem(at: settings.IncommingTransferAlertType)
        txtComputerName.stringValue = settings.ComputerName
        
        
    }
   
    @IBAction func onCancel(_ sender: Any) {
        // return app activation to accessory (hide dock icon and deactivate app returning focus to previousy active app/window)
        NSApp.setActivationPolicy(.accessory)

        self.view.window?.performClose(self)
    }
    
    @IBAction func onSave(_ sender: Any) {
        
        if (txtComputerName.stringValue.isEmpty) {
            return
        }
        
        let newName = txtComputerName.stringValue.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if (settings.ComputerName != newName) {
            // restart TCP listener with new computer name
            
            let appDelegate = NSApplication.shared.delegate as! AppDelegate
            appDelegate.restartConnection()
            
            settings.ComputerName = newName
        }
        
        settings.IncommingTransferAlertType = cbAlertType.indexOfSelectedItem
        settings.SaveSettings()
        
        // return app activation to accessory (hide dock icon and deactivate app returning focus to previousy active app/window)
        NSApp.setActivationPolicy(.accessory)
        
        self.view.window?.performClose(self)
    }
    
}
