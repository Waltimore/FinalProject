//
//  Actor.swift
//  FinalProject
//
//  Created by David van der Velden on 11/12/2017.
//  Copyright © 2017 David van der Velden. All rights reserved.
//
import Foundation
import Firebase

struct Actor: Codable {
    let name: String
    let description: String
    let dob: String
    //let image: URL
    //let ref = DatabaseReference?.self
    
    init(name: String, description: String, dob: String) {
        self.name = name
        self.description = description
        self.dob = dob
        //self.image = image
        //self.ref = nil
    }

    init(snapshot: DataSnapshot) {
        let snapshotValue = snapshot.value as! [String: AnyObject]
        name = snapshotValue["name"] as! String
        description = snapshotValue["description"] as! String
        dob = snapshotValue["dob"] as! String
        //image = snapshotValue["image"] as! URL
    }
    
    func toAnyObject() -> Any {
        return [
            "name": name,
            "description": description,
            "dob": dob,
            //"image": image
        ]
    }
}


struct Actors: Codable {
    let actors: [Actor]
}

