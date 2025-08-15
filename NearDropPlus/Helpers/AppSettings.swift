//
//  AppSettings.swift
//  NearDrop
//
//  Created by Konstantin Adamov on 4/14/23.
//

import Foundation
class AppSettings: NSObject {
    private let ComputerNameKey = "ComputerName"
    private let AutoOpenSafeFilesKey = "AutoOpenSafeFiles"
    private let OpenURLInBrowserKey = "OpenURLInBrowser"
    
    static let sharedInstance: AppSettings = AppSettings()
    
    var ComputerName : String = Host.current().localizedName!
    var AutoOpenSafeFiles : Bool = false
    var OpenURLInBrowser : Bool = false
    
    fileprivate override init() {
        super.init()
        
        loadSettings()
    }
    
    func loadSettings(){
        let prefs = UserDefaults.standard
        
        AutoOpenSafeFiles = prefs.object(forKey: AutoOpenSafeFilesKey) as? Bool ?? false
        OpenURLInBrowser = prefs.object(forKey: OpenURLInBrowserKey) as? Bool ?? false
        ComputerName = prefs.string(forKey: ComputerNameKey) ?? Host.current().localizedName!
        
    }
    
    func SaveSettings(){
        let prefs = UserDefaults.standard
        
        prefs.set(ComputerName, forKey: ComputerNameKey)
        prefs.set(AutoOpenSafeFiles, forKey: AutoOpenSafeFilesKey)
        prefs.set(OpenURLInBrowser, forKey: OpenURLInBrowserKey)
    }
  
}
