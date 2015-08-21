//
//  Game.swift
//  SharpPoint
//
//  Created by Joshua O'Connor on 3/14/15.
//  Copyright (c) 2015 Joshua O'Connor. All rights reserved.
//

import Foundation
import CoreData

class Game: NSManagedObject {

    @NSManaged var game: String
    @NSManaged var players: NSNumber
    @NSManaged var picture: String
    @NSManaged var tableData: String
    @NSManaged var latitude: NSNumber
    @NSManaged var longitude: NSNumber
    @NSManaged var locationTitle: String

}
