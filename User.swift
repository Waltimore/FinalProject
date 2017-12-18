//
//  User.swift
//  
//
//  Created by David van der Velden on 10/12/2017.
//

import Foundation
import FirebaseAuthUI
import Firebase
import FirebaseDatabase

struct User {
    
    let uid: String
    let email: String
    
    init(authData: Firebase.User) {
        uid = authData.uid
        email = authData.email!
    }
    
    init(uid: String, email: String) {
        self.uid = uid
        self.email = email
    }
    
}
