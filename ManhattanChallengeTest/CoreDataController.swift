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
    
    var currentTrip: Trip?
    var isTripAdded: Bool = false
    
    private init() {
        let application = UIApplication.shared.delegate as! AppDelegate
        self.context = application.persistentContainer.viewContext
//        I create this fake trip to test the classes
//        let trip = Trip(entity: NSEntityDescription.entity(forEntityName: "Trip", in: context)!, insertInto: context)
//        trip.location = "Rome"
//        trip.budget = 400.00
//        REMEMBER TO CANCEL THIS:
//        currentTrip = Trip(entity: NSEntityDescription.entity(forEntityName: "Trip", in: context)!, insertInto: context)
//        currentTrip?.location = "Firenze"
//        currentTrip?.budget = 400
    }
    
    func addTrip(location: String, budget: Float) {
        let entity = NSEntityDescription.entity(forEntityName: "Trip", in: self.context)
        
        let newTrip = Trip(entity: entity!, insertInto: self.context)
        newTrip.location = location
        newTrip.budget = budget
        newTrip.date = Date()
        
        do {
            try self.context.save()
        } catch let error {
            print("[CDC] Error saving trip: error \(error)")
        }
        
        self.currentTrip = newTrip

        print("[CDC] trip correctly saved")
        
    }
    
//    func addExpense(cathegory: String?, note: String?, price: Float?) {
//        let entity = NSEntityDescription.entity(forEntityName: "Expense", in: self.context)
//
//        let newExpense = Expense(entity: entity!, insertInto: self.context)
//        newExpense.cathegory = cathegory ?? ""
//        newExpense.price = price ?? 0.0
//        newExpense.note = note ?? ""
//
//        do {
//            try self.context.save()
//        } catch let error {
//            print("[CDC] Error saving expense: error \(error)")
//        }
//
//        print("[CDC] expense correctly saved")
//
//    }
    
    func loadCurrentTrip() -> Trip? {
        var trips: [Trip]?
        let tripFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Trip")
        do {
            trips = (try context.fetch(tripFetch) as! [Trip]) }
        catch let error {
            print("[CDC] Problem executing FetchRequest")
            print("  Print Error: \n \(error) \n")
        }
        
        if trips!.count == 0 {
            return nil
        }
        print(trips!.count)
        
        return trips![trips!.count - 1]
    }
    
    func loadTrip(location: String) -> Trip {
        let tripFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Trip")
        tripFetch.predicate = NSPredicate(format: "location = %@", location)
        tripFetch.fetchLimit = 1
        var fetchTrip: [Trip] = []
        do {
            fetchTrip = try context.fetch(tripFetch) as! [Trip]
        } catch let error {
            print("[CDC] Problem executing FetchRequest")
            print("  Print Error: \n \(error) \n")
        }
        return fetchTrip[0]
    }
    
    //Load all expenses
    func loadExpenses() {
        print("[CDC] Recovering expenses ")
        
        let fetchRequest: NSFetchRequest<Expense> = Expense.fetchRequest()
        
        do {
            let expenses = try self.context.fetch(fetchRequest)
            
            guard expenses.count > 0 else {print("[CDC] Non ci sono elementi da leggere "); return}
            
            for expense in expenses {
                print("[CDC] Expense: \(expense.price), Cathegory: \(expense.cathegory ?? ""), note: \(expense.note ?? "")")
            }
            
        } catch let error {
            print("[CDC] Problem executing FetchRequest")
            print("  Print error: \n \(error) \n")
        }
    }    
    
    func addExpenseToATrip(cathegory: String?, note: String?, price: Float?, photo: UIImage?, trip: Trip) {
        let entity = NSEntityDescription.entity(forEntityName: "Expense", in: self.context)
        
        let newExpense = Expense(entity: entity!, insertInto: self.context)
        trip.addToExpenses(newExpense)
        newExpense.cathegory = cathegory ?? ""
        newExpense.price = price ?? 0.0
        newExpense.note = note ?? ""
        newExpense.date = Date()
        
        if let photoTaken = photo {
            newExpense.image = UIImagePNGRepresentation(photoTaken)
        } else {
            newExpense.image = nil
        }
        
        
        
        do {
            try self.context.save()
        } catch let error {
            print("[CDC] Error saving expense: error \(error)")
        }
        
        print("[CDC] expense correctly saved")
    }
    
    func loadExpensesOfCurrentTrip() -> [Expense] {
        let trip = loadCurrentTrip()
        let expenses = loadExpensesOfATrip(trip: trip!)
        return expenses
    }
    
    
    func loadExpensesOfATrip(trip: Trip) -> [Expense] {
        print("[CDC] Recovering expenses ")
        
        var expenses: [Expense] = []
        
        do {
//          Need to pass to this function the trip you want to look up the expenses
            expenses = trip.expenses?.allObjects as! [Expense]
            
            guard expenses.count > 0 else {
                print("[CDC] No elements to read")
                return []
                
            }
            
            for expense in expenses {
                print("[CDC] Expense: \(expense.price), Cathegory: \(expense.cathegory ?? ""), note: \(expense.note ?? ""), trip: \(trip.location ?? "")")
            }
        }
        
        return expenses
    }
    
    func loadExpensesOfCategoryGivenTrip(trip: Trip, category: String) -> [Expense] {
        
        let expenses = loadExpensesOfATrip(trip: trip)
        var fetchedExpenses: [Expense] = []
        
        for expense in expenses {
            if expense.cathegory == category {
                fetchedExpenses.append(expense)
            }
        }
        
        if fetchedExpenses.count > 1 {
            fetchedExpenses.sort() {
                $0.date! > $1.date!
            }
        }
        
        return fetchedExpenses
    }

    func loadAllTheTrips() -> [Trip] {
        let fetchRequest: NSFetchRequest<Trip> = Trip.fetchRequest()
        var trips = [Trip]()
        do {
            trips = try self.context.fetch(fetchRequest)
            
            guard trips.count > 0 else {print("[CDC] Non ci sono elementi da leggere "); return[]}
            
            for trip in trips {
                print("[CDC] Trip location: \(trip.location!)")
            }
            
        } catch let errore {
            print("[CDC] Problema esecuzione FetchRequest")
            print("  Stampo l'errore: \n \(errore) \n")
        }
        
        if trips.count > 1 {
            trips.sort() {
                $0.date! > $1.date!
            }
        }
        
        return trips
    }
    
    func deleteTrip(location: String) {
        let fetchRequest: NSFetchRequest<Trip> = Trip.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "location = %@", location)
        do{
            let result = try context.fetch(fetchRequest)
            for object in result {
                context.delete(object)
            }
        } catch let error {
            print("[CDC] Problem deleting object")
            print("  Print Error: \n \(error) \n")
        }
        
        do {
            try self.context.save()
        } catch let error {
            print("[CDC] Error deleting trip: error \(error)")
        }
        
        print("[CDC] expense correctly saved")
    }
    
    
    func editExpense(date: Date, cathegory: String?, note: String?, price: Float?, photo: UIImage?) {
        
        let fetchRequest: NSFetchRequest<Expense> = Expense.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "date = %@", date as CVarArg)
        
        do {
             var result = try context.fetch(fetchRequest)
            
            result[0].price = price ?? 0.0
            result[0].cathegory = cathegory ?? ""
            result[0].note = note ?? ""
            
            if let photoTaken = photo {
                result[0].image = UIImagePNGRepresentation(photoTaken)
            } else {
                result[0].image = nil
            }
            
            print(result[0])
            
            try self.context.save()
            
        } catch let error {
            print("[CDC] Error editing trip: error \(error)")
        }

        
    }
    
    func FloatToTwoDigitString(number: Float) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        
        return formatter.string(from: NSNumber(value: number))!
    }
}












