//
//  MyTripsTableTableViewController.swift
//  ManhattanChallengeTest
//
//  Created by Francesca Palese on 13/12/2017.
//  Copyright © 2017 Simone Garuglieri. All rights reserved.
//

import UIKit

class MyTripsTableTableViewController: UITableViewController {

    var isTripAdded: Bool?
    
    var myTrips = CoreDataController.shared.loadAllTheTrips()
    var indexOfSelectedTrip = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        myTrips = CoreDataController.shared.loadAllTheTrips()
        self.tableView.reloadData()
        
        if CoreDataController.shared.isTripAdded {
            CoreDataController.shared.isTripAdded = false
            
            navigationController?.popViewController(animated: false)
            dismiss(animated: false, completion: nil)
        }
        
        self.navigationController?.navigationBar.tintAdjustmentMode = .normal
        self.navigationController?.navigationBar.tintAdjustmentMode = .automatic
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return myTrips.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let trip = self.myTrips[indexPath.row]
        
        cell.textLabel?.text = trip.location

        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath)
    {
        if editingStyle == .delete
        {
            if myTrips.count == 1 {
                //Show alert
                    let alertView = UIAlertController(title: "You need to have at least one trip", message: "", preferredStyle: .alert)
                    alertView.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                    present(alertView, animated: true, completion: nil)
                    return
                }
            
            tableView.beginUpdates()

            CoreDataController.shared.deleteTrip(location: myTrips[indexPath.row].location!)
            
            do {
                try CoreDataController.shared.context.save()
            } catch let error {
                print("[CDC] Error deleting trip: error \(error)")
            }
            
            myTrips.remove(at: indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
            
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        indexOfSelectedTrip = indexPath.row
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let nextViewController = segue.destination as? TripDetailViewController {
            nextViewController.trip = myTrips[indexOfSelectedTrip]
        }
    }
    
    
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
