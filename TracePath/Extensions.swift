//
//  Extensions.swift
//  TracePath
//
//  Created by Cofyc on 8/31/14.
//
//

import Foundation

// global variables
let statusBarFrame = UIApplication.sharedApplication().statusBarFrame
let screenRect = UIScreen.mainScreen().bounds
let screenWidth = screenRect.size.width
let screenHeight = screenRect.size.height

// log
func log(message: String) {
    let window = UIApplication.sharedApplication().keyWindow
    if let rootViewController:ViewController = window.rootViewController as? ViewController {
        let debugViewController:DebugViewController = rootViewController.debugViewController
        debugViewController.log(message)
    }
}

// Add format function for String type.
func StringWithFormat(format: String, args: CVarArgType...) -> String {
    return NSString(format: format, arguments: getVaList(args))
}

extension String {
    func format(args: CVarArgType...) -> String {
        return NSString(format: self, arguments: getVaList(args))
    }
}

// UIView
// http://stackoverflow.com/a/24370563/288089
extension UIView {
    func loadFromNibNamed(nibNamed: String, bundle : NSBundle = NSBundle.mainBundle()) -> UIView! {
        return UINib(nibName: nibNamed, bundle: bundle).instantiateWithOwner(nil, options: nil)[0] as? UIView
    }
}