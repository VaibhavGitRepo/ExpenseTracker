//
//  SideViewContent.swift
//  SignIn and SignUp
//
//  Created by Vaibhav Sharma on 24/07/24.
//

import SwiftUI

struct SideViewContent: View {
    @State private var showAlert = false
    @State private var alertMessage: String = ""
    @State private var navigateToGetStarted = false
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        NavigationStack{
            ZStack{
                Color.background.ignoresSafeArea()
                if let user = viewModel.currentUser{
                VStack {
                    HStack{
                        Text(user.initials)
                            .font(.title)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .frame(width: 72,height: 72)
                            .background(Color(.icon))
                            .clipShape(Circle())
                        
                        VStack(alignment: .leading,spacing: 4){
                            Text(user.fullname)
                                .font(.title2)
                                .fontWeight(.semibold)
                                .padding(.top,12)
                            Text(user.email)
                                .font(.title3)
                                .accentColor(.black)
                        }
                    }
                    Spacer()
                    VStack(alignment: .leading,spacing: 10){
                        Button{
                            viewModel.signOut()
                        }label: {
                            HStack{
                                Image(systemName: "arrow.left.circle.fill")
                                    .imageScale(.medium)
                                    .font(.title2)
                                    .foregroundColor(.red)
                                
                                Text("Sign Out")
                                    .font(.title3)
                                    .accentColor(.red)
                            }
                        }
                        Button{
                            Task{
                                do{
                                    try await viewModel.deleteAccount()
                                    alertMessage = "Account Deleted Succesfully"
                                    showAlert = true
                                }catch{
                                    alertMessage = error.localizedDescription
                                    showAlert = true
                                }
                            }
                        }label: {
                            HStack{
                                Image(systemName: "multiply.circle.fill")
                                    .imageScale(.medium)
                                    .font(.title2)
                                    .foregroundColor(.red)
                                Text("Delete account")
                                    .font(.title3)
                                    .accentColor(.red)
                                
                            }
                        }
                    }
                    
                    .alert(isPresented: $showAlert) {
                        Alert(
                            title: Text("Account Deletion"),
                            message: Text(alertMessage),
                            dismissButton: .default(Text("OK"))
                        )
                    }
                    .navigationDestination(isPresented: $navigateToGetStarted) { ContentView()}
                    }
                }
            }
        }
    }
}


#Preview {
    SideViewContent()
}
