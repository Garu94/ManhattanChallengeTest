//
//  CoreDataController.swift
//  ManhattanChallengeTest
//
//  Created by Mario Munno on 12/12/2017.
//  Copyright © 2017 Simone Garuglieri. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class CoreDataController {
    static let shared = CoreDataController()
    
    public var context: NSManagedObjectContext
    
    private init() {
        let application = UIApplication.shared.delegate as! AppDelegate
        self.context = application.persistentContainer.viewContext
    }
}
