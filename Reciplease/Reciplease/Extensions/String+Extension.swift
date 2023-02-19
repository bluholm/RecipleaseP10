//
//  StringExtension.swift
//  Reciplease
//
//  Created by Marc-Antoine BAR on 2022-12-12.
//

import Foundation

extension String {
    
    static func uniqueFilename(withPrefix prefix: String? = nil) -> String {
        let uniqueString = ProcessInfo.processInfo.globallyUniqueString
        if prefix != nil {
            return "\(prefix!)-\(uniqueString)"
        }
        return uniqueString
    }
    
}
