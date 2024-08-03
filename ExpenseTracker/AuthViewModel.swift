//
//  AuthViewModel.swift
//  SignIn and SignUp
//
//  Created by Vaibhav Sharma on 24/07/24.
//

import Foundation
import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

protocol AuthenticationFormProtocol{
    var formIsValid: Bool {get}
}

class AuthViewModel : ObservableObject {
    @Published var usersession: FirebaseAuth.User?
    @Published var currentUser: User?
    @State private var showAlert = false
    private var db = Firestore.firestore()
    
   
    init(){
        self.usersession = Auth.auth().currentUser
        
        Task{ await fetchUser() }
    }
    
    func signIn(withEmail email: String, password: String) async throws{
        do{
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.usersession = result.user
            await fetchUser()
        } //catch{ print("DEBUG: Failed to sign in with error\(error.localizedDescription)") }
    }
    
    func createUser(withEmail email: String, password: String, fullname: String ) async throws{
        do{
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.usersession = result.user
            let user = User(id: result.user.uid, fullname: fullname, email: email)
            let encodedUser  =  try Firestore.Encoder().encode(user)
            try await Firestore.firestore().collection("users").document(user.id).setData(encodedUser)
            await fetchUser()
        } //catch{ print("DEBUG: Failed to create user with error \(error.localizedDescription)") }
    }
    
    func signOut() {
        Task{
            try Auth.auth().signOut()
            self.usersession = nil
            self.currentUser = nil
        } //catch{ print("DEBUG: Failed to sign out with error\(error.localizedDescription)") }
    }
    
    func deleteAccount() async throws{
        guard let user = Auth.auth().currentUser else{throw NSError(domain: "No user signed in", code: 0, userInfo: nil)}
        try await deleteUserFromFirestore(userId: user.uid)
        try await user.delete()
    }
    
    private func deleteUserFromFirestore(userId: String) async throws {
            let userRef = db.collection("users").document(userId)
            try await userRef.delete()
        }
    
    func fetchUser() async{
        guard let uid = Auth.auth().currentUser?.uid else{return} 
        guard let snapshot = try? await Firestore.firestore().collection("users").document(uid).getDocument() else { return }
        self.currentUser = try? snapshot.data(as: User.self)
        
        //print("DEBUG: Current user is \(self.currentUser)")
    }
}
