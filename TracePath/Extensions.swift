//
//  Extensions.swift
//  TracePath
//
//  Created by Cofyc on 8/31/14.
//
//

import Foundation

// Add format function for String type.
func StringWithFormat(format : String, args: CVarArgType...) -> String {
    return NSString(format: format, arguments: getVaList(args))
}

extension String {
    func format(args: CVarArgType...) -> String {
        return NSString(format: self, arguments: getVaList(args))
    }
}