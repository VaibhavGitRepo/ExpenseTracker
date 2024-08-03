//
//  Input.swift
//  SignIn and SignUp
//
//  Created by Vaibhav Sharma on 24/07/24.
//

import SwiftUI

struct Input: View {
    @Binding var text: String
    let title: String
    var isSecureField = false
    
    var body: some View {
        
        if isSecureField{
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.gray, lineWidth: 1)
                .frame(width: 358,height: 56)
                .overlay{
                    SecureField(title,text: $text)
                        .font(Font.system(size: 16))
                        .foregroundColor(Color.gray)
                        .frame(alignment: .leading)
                        .padding(.horizontal, 10)
                    
                }
        }else{
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.gray, lineWidth: 1)
                .frame(width: 358,height: 56)
                .overlay{
                    TextField(title,text: $text)
                        .font(Font.system(size: 16))
                        .foregroundColor(Color.gray)
                        .frame(alignment: .leading)
                        .padding(.horizontal, 10)
                    
                }
        }
        
    }
}

#Preview {
    Input(text: .constant(""), title: "Email")
}
