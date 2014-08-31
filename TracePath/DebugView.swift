//
//  DebugView.swift
//  TracePath
//
//  Created by Cofyc on 8/30/14.
//
//

import Foundation

class DebugView: UIView {

    override func pointInside(point: CGPoint, withEvent event: UIEvent!) -> Bool {
        println("clicked here");
        return false
    }
}