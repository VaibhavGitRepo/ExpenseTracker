//
//  ContentView.swift
//  ExpenseTracker
//
//  Created by Vaibhav Sharma on 26/07/24.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel : AuthViewModel
    
    var body: some View {
        Group{
            if viewModel.usersession != nil{
                HomeView()
            } else{
                GetStarted()
            }
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(AuthViewModel())
}
