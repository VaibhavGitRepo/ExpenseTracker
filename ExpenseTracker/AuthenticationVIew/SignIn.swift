//
//  SignIn.swift
//  ExpenseTracker
//
//  Created by Vaibhav Sharma on 21/07/24.
//

import SwiftUI

struct SignIn: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var showAlert = false
    @State private var alertMessage: String = ""
    @Environment (\.dismiss) var dismiss
    @EnvironmentObject var viewModel: AuthViewModel
    var body: some View {
        NavigationView{
            ZStack{
                Color("Background")
                VStack{
                    Text("Welcome !")
                        .font(Font.system(size: 32))
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                    
                    Input(text: $email, title: "Email")
                        .autocapitalization(.none)
                        
                    Input(text: $password, title: "Password", isSecureField: true)
                        .padding()
                    
                    
                    NavigationLink{
                        
                    }label: {
                        Text("Forget Password?")
                            .underline()
                            .font(Font.system(size: 18))
                            .frame(maxWidth: .infinity,alignment: .trailing)
                            .padding(.trailing)
                    }

                    RoundedRectangle(cornerRadius: 44)
                        .fill(LinearGradient(gradient: Gradient(colors:[Color(.systemTeal),Color(.systemPurple)]), startPoint: .leading, endPoint: .trailing))
                        .frame(width: 358, height: 56)
                        .overlay{
                            CustomButton(title: "Sign in", width: 358, height: 56, cornerRadius: 49,size: 16){
                                Task{
                                    do{
                                        try await viewModel.signIn(withEmail: email, password: password)
                                    }catch{
                                        alertMessage = error.localizedDescription
                                        showAlert = true
                                    }
                                }
                            }
                            
                        }
                        .disabled(formIsValid)
                        .opacity(formIsValid ? 1.0 : 0.5)
                        .padding()
                    HStack{
                        Image("line")
                        Text("or continue with")
                            .font(Font.system(size: 14))
                        Image("line")
                    }
                    
                    SocalLoginButton(image: Image("apple"), text: Text("Sign In with Apple").foregroundColor(.white))
                    
                    SocalLoginButton(image: Image("googlelogo-2"), text: Text("Sign In with Google").foregroundColor(.white))
                    
                    Text("By proceeding you agree to company").font(Font.system(size: 16))
                    HStack{
                        Text("Terms of use").font(Font.system(size: 16))
                            .foregroundStyle(Color.purple)
                        Text("&").font(Font.system(size: 16))
                        Text("Privacy policy").font(Font.system(size: 16))
                            .foregroundStyle(Color.purple)
                    }
                    Spacer()
                    HStack{
                     Text("Don't have an account?")
                        NavigationLink(destination: SignUp().navigationBarHidden(true)){
                            Text("Sign Up")
                                .foregroundStyle(Color.purple)
                                .underline()
                        }
                    }
                }
                .padding()
            }
            .background(Color.background)
            .alert(isPresented: $showAlert){
                Alert(
                    title: Text("Sign In Failed"),
                    message: Text(alertMessage),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
    }
}

extension SignIn : AuthenticationFormProtocol{
    var formIsValid: Bool{
        return !email.isEmpty
        && email.contains("@")
        && !password.isEmpty
        && password.count > 5
    }
}

#Preview {
    SignIn()
        .environmentObject(AuthViewModel())
}
