//
//  ExpenseTrackerApp.swift
//  ExpenseTracker
//
//  Created by Vaibhav Sharma on 20/07/24.
//

import SwiftUI
import Firebase

@main
struct ExpenseTrackerApp: App {
    @StateObject  var transactionListVM = TransactionListViewModel()
    @StateObject var viewModel = AuthViewModel()
    
    init(){
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(transactionListVM)
                .environmentObject(viewModel)
        }
    }
}
