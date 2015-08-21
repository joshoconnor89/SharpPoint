//
//  SharpPoint.swift
//  SharpPoint
//
//  Created by Joshua O'Connor on 2/23/15.
//  Copyright (c) 2015 Joshua O'Connor. All rights reserved.
//

import Foundation
import CoreData

class Geolocation: NSManagedObject {

    @NSManaged var latitude: NSNumber
    @NSManaged var longitude: NSNumber

}
