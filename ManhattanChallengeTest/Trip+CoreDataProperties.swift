//
//  Trip+CoreDataProperties.swift
//  ManhattanChallengeTest
//
//  Created by Mario Munno on 12/12/2017.
//  Copyright © 2017 Simone Garuglieri. All rights reserved.
//
//

import Foundation
import CoreData


extension Trip {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Trip> {
        return NSFetchRequest<Trip>(entityName: "Trip")
    }

    @NSManaged public var budget: Float
    @NSManaged public var location: String?

}
