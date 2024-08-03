//
//  ContentView.swift
//  ExpenseTracker
//
//  Created by Vaibhav Sharma on 20/07/24.
//

import SwiftUI

struct GetStarted: View {
    var body: some View {
        NavigationView{
                    VStack{
                        Image("scrollview")
                            .frame(width: 20,height: 400)
                        Text("Save Your Money")
                            .font(Font.system(size: 30))
                            .font(.title)
                            .fontWeight(.bold)
                        Text("Best Solution to save and invest your money.")
                            .font(Font.system(size: 25))
                            .multilineTextAlignment(.center)
                            .foregroundColor(Color(.systemGray))
                            .frame(width: 250,height: 75)
                        NavigationLink(destination: SignUp().navigationBarHidden(true)){
                            RoundedRectangle(cornerRadius: 49)
                                .fill(LinearGradient(gradient: Gradient(colors:[Color(.systemTeal),Color(.systemPurple)]), startPoint: .leading, endPoint: .trailing))
                                .frame(width: 358,height: 56)
                                .overlay{
                                        Text("Get Started")
                                            .font(Font.system(size: 20))
                                            .foregroundColor(Color.white)
                                            .frame(alignment: .leading)
                                    
                                }
                        }
                    }
    
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing){
                        NavigationLink(destination: SignIn().navigationBarBackButtonHidden(true)){
                            Text("Sign in")
                                .font(.system(size: 23))
                                .foregroundColor(Color(.systemGray))
                        }
                    }
                }
                .padding()
                
        }
        .navigationViewStyle(.stack)
    }
}

#Preview {
    GetStarted()
}
