//
//  AppSettings.swift
//  NearDrop
//
//  Created by Konstantin Adamov on 4/14/23.
//

import Foundation
class AppSettings: NSObject {
    
    static let sharedInstance: AppSettings = AppSettings()
    
    var ComputerName : String = Host.current().localizedName!
    var IncommingTransferAlertType : Int = 0
    
    fileprivate override init() {
        super.init()
        
        loadSettings()
    }
    
    func loadSettings(){
        let prefs = UserDefaults.standard
        
        if prefs.object(forKey: "IncommingTransferAlertType") != nil  {
            IncommingTransferAlertType=prefs.integer(forKey: "IncommingTransferAlertType")
        }
        
        ComputerName = prefs.string(forKey: "ComputerName") ?? Host.current().localizedName!
        
    }
    
    func SaveSettings(){
        let prefs = UserDefaults.standard
        
        prefs.set(IncommingTransferAlertType, forKey: "IncommingTransferAlertType")
        prefs.set(ComputerName, forKey: "ComputerName")
    }
  
}
