//
//  Location.swift
//  TracePath
//
//  Created by Cofyc on 9/7/14.
//
//

import Foundation
import CoreData

@objc(Location)
class Location: NSManagedObject {

    @NSManaged var latitude: NSNumber
    @NSManaged var longitude: NSNumber
    @NSManaged var record: NSSet

}
