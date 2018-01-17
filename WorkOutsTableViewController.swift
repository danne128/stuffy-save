//
//  WorkOutsTableViewController.swift
//  Trainingapp
//
//  Created by Daniel Trondsen Wallin on 2017-12-06.
//  Copyright © 2017 Daniel Trondsen Wallin. All rights reserved.
//

import UIKit
import Firebase

class WorkOutsTableViewController: UITableViewController {
    
    var workOuts: [String] = []
    var amountOfExercises: [Int] = []
    var ref: DatabaseReference!
    var userID: String!
    var workOutPath: DatabaseReference!
    var end = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.navigationItem.hidesBackButton = true
        
        ref = Database.database().reference()
        userID = Auth.auth().currentUser?.uid
        workOutPath = ref.child("users").child(userID).child("workouts")
        
        workOutPath.observeSingleEvent(of: .value) { (snapshot) in
            let value = snapshot.value as? NSDictionary
            let keys = value!.allKeys
            for key in keys {
                self.workOuts.append(key as! String)
            }
            //print(self.workOuts)
            self.getExercises()
        }
        
        tableView.tableFooterView = UIView()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        //self.navigationItem.rightBarButtonItem = self.editButtonItem
        self.navigationItem.setHidesBackButton(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        end = false
    }
    
    func getExercises() {
        for exercise in workOuts {
            workOutPath.child("\(exercise)").observeSingleEvent(of: .value, with: { (snapshot) in
                let value = snapshot.value as? NSDictionary
                let keys = value!.allKeys
                self.amountOfExercises.append(keys.count)
                
                if self.amountOfExercises.count == self.workOuts.count {
                    self.end = true
                    //print(self.amountOfExercises)
                }
                
                if self.end == true {
                    self.tableView.reloadData()
                }
            })
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        return workOuts.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //let cell = tableView.dequeueReusableCell(withIdentifier: "workOutsCell", for: indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! WorkoutsTableViewCell
        
        cell.workOutNameLabel.adjustsFontSizeToFitWidth = true
        cell.workOutCountLabel.adjustsFontSizeToFitWidth = true
        cell.workOutNameLabel.text = workOuts[indexPath.row]
        //cell.workOutCountLabel.text = "\(amountOfExercises[indexPath.row])"
        if amountOfExercises[indexPath.row] == 1 {
            cell.workOutCountLabel.text = "You have \(amountOfExercises[indexPath.row]) exercise in this workout"
        }
        else {
            cell.workOutCountLabel.text = "You have \(amountOfExercises[indexPath.row]) exercises in this workout"
        }
        // Configure the cell...

        return cell
    }
    
    
    @IBAction func logOutButtonWasClicked(_ sender: Any) {
        do {
            try Auth.auth().signOut()
        } catch let signOutError as NSError {
            print("Error signing out", signOutError)
        }
    }
    

}
