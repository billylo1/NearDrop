//
//  PreferencesViewController.swift
//  NearDrop
//
//  Created by Konstantin Adamov on 4/14/23.
//

import Cocoa
import LaunchAtLogin

class PreferencesViewController: NSViewController {

    @objc dynamic var launchAtLogin = LaunchAtLogin.kvo
    
    private let settings = AppSettings.sharedInstance
    
    @IBOutlet weak var txtComputerName: NSTextField!
    @IBOutlet weak var cbAlertType: NSComboBox!
    @IBOutlet weak var txtError: NSTextField!
    @IBOutlet weak var cbLaunchAtLogin: NSButton!
    @IBOutlet weak var cbAutoOpenFiles: NSButton!
    @IBOutlet weak var cbAutoOpenURL: NSButton!
    @IBOutlet weak var cbAutoAcceptFiles: NSButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        cbAlertType.selectItem(at: settings.IncommingTransferAlertType)
        txtComputerName.stringValue = settings.ComputerName
        txtError.stringValue = ""
        cbLaunchAtLogin.state = (LaunchAtLogin.isEnabled) ? .on : .off
        cbAutoOpenFiles.state = settings.AutoOpenSafeFiles ? .on : .off
        cbAutoOpenURL.state = settings.OpenURLInBrowser ? .on : .off
        cbAutoAcceptFiles.state = settings.AutoAcceptFiles ? .on : .off
    }
   
    @IBAction func onCancel(_ sender: Any) {
        // return app activation to accessory (hide dock icon and deactivate app returning focus to previousy active app/window)
        NSApp.setActivationPolicy(.accessory)

        close()
    }
    
    @IBAction func onSave(_ sender: Any) {
        let appDelegate = NSApplication.shared.delegate as! AppDelegate

        let newName = txtComputerName.stringValue.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if (newName.isEmpty || newName.count <= 3) {
            txtError.stringValue =  NSLocalizedString("ComputerNameTooShort", comment: "") 
            return
        }
        
        txtError.stringValue = ""

        LaunchAtLogin.isEnabled = cbLaunchAtLogin.state == .on
        settings.AutoOpenSafeFiles = cbAutoOpenFiles.state == .on
        settings.OpenURLInBrowser = cbAutoOpenURL.state == .on
        settings.AutoAcceptFiles = cbAutoAcceptFiles.state == .on
        settings.IncommingTransferAlertType = cbAlertType.indexOfSelectedItem
        
        if (settings.ComputerName != newName) {
            // restart TCP listener with new computer name
            
            settings.ComputerName = newName
            appDelegate.restartConnection()
        }

        appDelegate.updateLaunchAtLoginMenuItem()
               
        settings.SaveSettings()
        
        close()
    }
    
    private func close(){
        // return app activation to accessory (hide dock icon and deactivate app returning focus to previousy active app/window)
        NSApp.setActivationPolicy(.accessory)
        
        self.view.window?.performClose(self)
    }
    
}
