//
//  AppDelegate.swift
//  NearDrop
//
//  Created by Grishka on 08.04.2023.
//

import Cocoa
import UserNotifications

@main
class AppDelegate: NSObject, NSApplicationDelegate{
    
    @IBOutlet weak var mainMenu: NSMenu!
    @IBOutlet weak var deviceNameMenuItem: NSMenuItem!
    
    private var connectionManager:NearbyConnectionManager?
    private var statusItem:NSStatusItem?
    
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        
        setDeviceNameMenuItem()
        
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        statusItem?.button?.image = NSImage(named: "MenuBarIcon")
        statusItem?.menu = mainMenu
        
        let nc=UNUserNotificationCenter.current()
        nc.requestAuthorization(options: [.alert, .sound]) { granted, err in
            if !granted{
                DispatchQueue.main.async {
                    self.showNotificationsDeniedAlert()
                }
            }
        }
        
        let incomingTransfersCategory=NDNotificationCenterHackery.hackedNotificationCategory()
        let errorsCategory=UNNotificationCategory(identifier: "ERRORS", actions: [], intentIdentifiers: [])
        
        nc.setNotificationCategories([incomingTransfersCategory, errorsCategory])
        connectionManager=NearbyConnectionManager()
        
        
    }

    @IBAction func showPreferences(_ sender: Any) {
        NSApp.setActivationPolicy(.regular)
        
        let storyboard = NSStoryboard(name: "Storyboard", bundle: nil)
        guard let vc = storyboard.instantiateInitialController() as? NSWindowController else {
            return
        }
        
        NSApp.activate(ignoringOtherApps: true)

        vc.window?.center()
        vc.window?.makeKeyAndOrderFront(nil)
    }

    
    func restartConnection(){
        setDeviceNameMenuItem()
        connectionManager?.restartMDNS()
    }
    
    func setDeviceNameMenuItem() {
        deviceNameMenuItem.title = String(format: NSLocalizedString("DeviceName", value: "Device name: %@", comment: ""), arguments: [AppSettings.sharedInstance.ComputerName])
    }
    
    func applicationWillTerminate(_ aNotification: Notification) {
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
    }
    
    func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
        return true
    }
    
    func showNotificationsDeniedAlert(){
        let alert=NSAlert()
        
        alert.alertStyle = .critical
        alert.messageText=NSLocalizedString("NotificationsDenied.Title", value: "Notification Permission Required", comment: "")
        alert.informativeText=NSLocalizedString("NotificationsDenied.Message", value: "NearDrop needs to be able to display notifications for incoming file transfers. Please allow notifications in System Settings.", comment: "")
        alert.addButton(withTitle: NSLocalizedString("NotificationsDenied.OpenSettings", value: "Open settings", comment: ""))
        alert.addButton(withTitle: NSLocalizedString("Quit", value: "Quit NearDrop", comment: ""))
        let result=alert.runModal()
        
        if result==NSApplication.ModalResponse.alertFirstButtonReturn {
            NSWorkspace.shared.open(URL(string: "x-apple.systempreferences:com.apple.preference.notifications")!)
        } else if result==NSApplication.ModalResponse.alertSecondButtonReturn {
            NSApplication.shared.terminate(nil)
        }
    }
}

