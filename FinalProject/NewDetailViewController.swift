//
//  NewDetailViewController.swift
//  FinalProject
//
//  Created by David van der Velden on 14/12/2017.
//  Copyright © 2017 David van der Velden. All rights reserved.
//

import UIKit
import Firebase

class NewDetailViewController: UIViewController {
    
    let ref = Database.database().reference(withPath: "favourite_actors")
    @IBAction func addPressed(_ sender: Any) {
        let faveActor = Actor(name: actor.name, description: actor.description, dob: actor.dob)
        let faveActorRef = self.ref.child(actor.name)
        faveActorRef.setValue(faveActor.toAnyObject())
    }
    
    
    var actor: Actor!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = actor.name
        updateUI()
        // Do any additional setup after loading the view.
    }
    @IBOutlet weak var actorImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var birthDateLabel: UILabel!
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateUI() {
        descriptionLabel.text = actor.description
        birthDateLabel.text = actor.dob
    }


}
