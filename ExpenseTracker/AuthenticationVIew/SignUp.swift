//
//  SignUp.swift
//  ExpenseTracker
//
//  Created by Vaibhav Sharma on 21/07/24.
//

import SwiftUI

struct SignUp: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var fullname: String = ""
    @State private var confirmPassword: String = ""
    @State private var showAlert = false
    @State private var alertMessage: String = ""
    @EnvironmentObject var viewModel : AuthViewModel
    var body: some View {
        NavigationView{
            ZStack{
                VStack(spacing: 8){
                    Spacer()
                    Text("Let's get started!")
                        .font(Font.system(size: 32))
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                    
                    Input(text: $fullname, title: "Name")
                    
                    Input(text: $email, title: "Email Id")
                        .autocapitalization(.none)
                    
                    Input(text: $password, title: "Password", isSecureField: true)
                    
                    ZStack(alignment: .trailing){
                        Input(text: $confirmPassword, title: "Confirm Password", isSecureField: true)
                        if !password.isEmpty && !confirmPassword.isEmpty{
                            if password == confirmPassword{
                                Image(systemName: "checkmark.circle.fill")
                                    .imageScale(.large)
                                    .fontWeight(.bold)
                                    .foregroundColor(Color(.systemGreen))
                            }else{
                                Image(systemName: "xmark.circle.fill")
                                    .imageScale(.large)
                                    .fontWeight(.bold)
                                    .foregroundColor(Color(.systemRed))
                            }
                        }
                    }
                    

                    RoundedRectangle(cornerRadius: 44)
                        .fill(LinearGradient(gradient: Gradient(colors:[Color(.systemTeal),Color(.systemPurple)]), startPoint: .leading, endPoint: .trailing))
                        .frame(width: 358, height: 56)
                        .overlay{
                            CustomButton(title: "Sign Up", width: 358, height: 56, cornerRadius: 49,size: 16){
                                Task{
                                    do{
                                        try await viewModel.createUser(withEmail: email,password:password,fullname: fullname)
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
                    
                    SocalLoginButton(image: Image("apple"), text: Text("Sign Up with Apple").foregroundColor(.white))
                    
                    SocalLoginButton(image: Image("googlelogo-2"), text: Text("Sign Up with Google").foregroundColor(.white))
                    
                    
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
                     Text("Already have an account?")
                        NavigationLink(destination: SignIn().navigationBarHidden(true)){
                            Text("Log in")
                                .foregroundStyle(Color.purple)
                                .underline()
                        }
                    }
                    .padding()
                }
                .padding()
            }
            .background(Color.background)
            .ignoresSafeArea()
            .alert(isPresented: $showAlert){
                Alert(
                    title: Text("Sign Up Failed"),
                    message: Text(alertMessage),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
    }
}

extension SignUp: AuthenticationFormProtocol{
    var formIsValid: Bool{
        return !email.isEmpty
        && email.contains("@")
        && !password.isEmpty
        && password.count > 5
        && confirmPassword == password
        && !fullname.isEmpty
        
    }
}

#Preview {
    SignUp()
        .environmentObject(AuthViewModel())
}
