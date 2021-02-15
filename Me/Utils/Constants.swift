//
//  Constants.swift
//  Me
//
//  Created by Darrien Huntley on 2/14/21.
//

import SwiftUI
import Firebase

// Lazy Grid
let columns = [
    
    GridItem(.flexible(), spacing: 0),
    GridItem(.flexible(), spacing: 0)
    
]

// Brand Name
let BRAND_NAME = "GOAT"

let COLLECTION_USERS = Firestore.firestore().collection("users")
let COLLECTION_ADMIN = Firestore.firestore().collection("admin")
let COLLECTION_SUBSCRIPTION = Firestore.firestore().collection("subscription")

let COLLECTION_ALL_USER_ITEMS = Firestore.firestore().collection("all user items")

let COLLECTION_REQUEST = Firestore.firestore().collection("requests")




//
let COLLECTION_FOLLOWERS = Firestore.firestore().collection("followers")
let COLLECTION_FOLLOWING = Firestore.firestore().collection("following")


let COLLECTION_TWEETS = Firestore.firestore().collection("tweets")
let COLLECTION_MESSAGES = Firestore.firestore().collection("messages")
