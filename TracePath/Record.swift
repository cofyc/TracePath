//
//  Record.swift
//  TracePath
//
//  Created by Cofyc on 9/7/14.
//
//

import Foundation
import CoreData

@objc(Record)
class Record: NSManagedObject {

    @NSManaged var title: String
    @NSManaged var date: NSDate
    @NSManaged var location: Location

}
