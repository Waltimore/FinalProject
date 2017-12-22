//
//  FaveTableViewController.swift
//  FinalProject
//
//  Created by David van der Velden on 18/12/2017.
//  Copyright © 2017 David van der Velden. All rights reserved.
//

import UIKit
import Firebase

class FaveTableViewController: UITableViewController {
    
    let ref = Database.database().reference(withPath: "favourite_actors")
    var faveActors: [Actor] = []
 
    override func viewDidLoad() {
        super.viewDidLoad()
        ref.observe(.value, with: { snapshot in
            
            var faveActors: [Actor] = []
            
            for item in snapshot.children {
                let actor = Actor(snapshot: item as! DataSnapshot)
                faveActors.append(actor)
            }
            
            self.faveActors = faveActors
            self.tableView.reloadData()
            //print(snapshot.value)
        })

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
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
        return faveActors.count
    }

    func configure(cell: UITableViewCell, forItemAt indexPath: IndexPath) {
        let actorName = self.faveActors[indexPath.row].name
        cell.textLabel?.text = actorName
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "faveCell", for: indexPath)

        configure(cell: cell, forItemAt: indexPath)

        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let actor = self.ref.child(self.faveActors[indexPath.row].name)
            actor.removeValue()
        }
    }
}
