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
    
    
    
    
}
