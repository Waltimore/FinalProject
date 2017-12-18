//
//  ListTableViewController.swift
//  FinalProject
//
//  Created by David van der Velden on 10/12/2017.
//  Copyright © 2017 David van der Velden. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseAuthUI

class ListTableViewController: UITableViewController {
    
    var user: User!
    
    @IBAction func signOutPressed(_ sender: Any) {
        do { try Auth.auth().signOut() } catch { print(error) }
        
        performSegue(withIdentifier: "backToLogin", sender: UIBarButtonItem.self)
    }
    
    var actors: [Actor] = []
    
    func retrieve() {
        let url = URL(string:"http://microblogging.wingnity.com/JSONParsingTutorial/jsonActors")!
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            let jsonDecoder = JSONDecoder()
            if let data = data,
                let actors = try? jsonDecoder.decode(Actors.self, from: data) {
                self.actors = actors.actors
            }
        }
        task.resume()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "actorCell", for: indexPath)
        configure(cell: cell, forItemAt: indexPath)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return actors.count
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailSegue" {
            let detailViewController = segue.destination as! NewDetailViewController
            let index = tableView.indexPathForSelectedRow!.row
            detailViewController.actor = actors[index]
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Auth.auth().addStateDidChangeListener { auth, user in
            guard let user = user else { return }
            self.user = User(authData: user)
        }
        retrieve()
    }

    func configure(cell: UITableViewCell, forItemAt indexPath: IndexPath) {
        let actorName = self.actors[indexPath.row].name
        cell.textLabel?.text = actorName
    }



    override func numberOfSections(in tableView: UITableView) -> Int {

        return 1
    }

}



