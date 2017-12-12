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
        /*  I create this fake trip to test the classes
        let trip = Trip(entity: NSEntityDescription.entity(forEntityName: "Trip", in: context)!, insertInto: context)
        trip.location = "Rome"
        trip.budget = 400.00
         */
    }
    
    func addTrip(location: String, budget: Float) {
        let entity = NSEntityDescription.entity(forEntityName: "Trip", in: self.context)
        
        let newTrip = Trip(entity: entity!, insertInto: self.context)
        newTrip.location = location
        newTrip.budget = budget
        
        do {
            try self.context.save()
        } catch let error {
            print("[CDC] Error saving trip: error \(error)")
        }
        
        print("[CDC] trip correctly saved")
        
    }
    
    func addExpense(cathegory: String?, note: String?, price: Float?) {
        let entity = NSEntityDescription.entity(forEntityName: "Expense", in: self.context)
        
        let newExpense = Expense(entity: entity!, insertInto: self.context)
        newExpense.cathegory = cathegory ?? ""
        newExpense.price = price ?? 0.0
        newExpense.note = note ?? ""
        
        do {
            try self.context.save()
        } catch let error {
            print("[CDC] Error saving expense: error \(error)")
        }
        
        print("[CDC] expense correctly saved")
        
    }
    
    func loadTrip(location: String) -> Trip {
        let tripFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Trip")
        tripFetch.predicate = NSPredicate(format: "location == %@", location)
        tripFetch.fetchLimit = 1
        var fetchTrip: [Trip] = []
        do {
            fetchTrip = try context.fetch(tripFetch) as! [Trip]
        } catch let errore{
            print("[CDC] Problema esecuzione FetchRequest")
            print("  Stampo l'errore: \n \(errore) \n")
        }
        return fetchTrip[0]
    }
    
    func loadExpenses() {
        print("[CDC] Recovering expenses ")
        
        let fetchRequest: NSFetchRequest<Expense> = Expense.fetchRequest()
        
        do {
            let expenses = try self.context.fetch(fetchRequest)
            
            guard expenses.count > 0 else {print("[CDC] Non ci sono elementi da leggere "); return}
            
            for expense in expenses {
                print("[CDC] Expense: \(expense.price), Cathegory: \(expense.cathegory ?? ""), note: \(expense.note ?? "")")
            }
            
        } catch let errore {
            print("[CDC] Problema esecuzione FetchRequest")
            print("  Stampo l'errore: \n \(errore) \n")
        }
    }
    
    
    func addExpenseToATrip(cathegory: String?, note: String?, price: Float?, trip: Trip) {
        let entity = NSEntityDescription.entity(forEntityName: "Expense", in: self.context)
        
        let newExpense = Expense(entity: entity!, insertInto: self.context)
        trip.addToExpenses(newExpense)
        newExpense.cathegory = cathegory ?? ""
        newExpense.price = price ?? 0.0
        newExpense.note = note ?? ""
        
        do {
            try self.context.save()
        } catch let error {
            print("[CDC] Error saving expense: error \(error)")
        }
        
        print("[CDC] expense correctly saved")
    }
    
    func loadExpensesOfATrip(trip: Trip) {
        print("[CDC] Recovering expenses ")
        
        do {
//          Need to pass to this function the trip you want to look up the expenses
            let exp = trip.expenses?.allObjects as! [Expense]
            
            guard exp.count > 0 else {print("[CDC] Non ci sono elementi da leggere "); return}
            
            for expen in exp {
                print("[CDC] Expense: \(expen.price), Cathegory: \(expen.cathegory ?? ""), note: \(expen.note ?? "")")
            }
            
        } catch let errore {
            print("[CDC] Problema esecuzione FetchRequest")
            print("Stampo l'errore: \n \(errore) \n")
        }
    }
}
