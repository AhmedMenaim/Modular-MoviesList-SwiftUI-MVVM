//
//  Print+Extensions.swift
//  
//
//  Created by Menaim on 06/08/2024.
//

import Foundation

/// Shadowing , To avoid having print statements on production (Only runs in debugging mode)
public 
func print(_ items: Any..., separator: String = " ", terminator: String = "\n") {
    #if DEBUG
        Swift.print(items, separator: separator, terminator: terminator)
    #endif
}
