//
//  Extentions.swift
//  NearDrop
//
//  Created by Konstantin Adamov on 6/4/23.
//

import Foundation
import AppKit
import UniformTypeIdentifiers
import CoreServices

extension URL {
    var isSafeToOpen: Bool {

        let mime = UTType(filenameExtension: self.pathExtension)
        
        return (mime?.conforms(to: .image) == true) || (mime?.conforms(to: .plainText) == true)
    }
}
