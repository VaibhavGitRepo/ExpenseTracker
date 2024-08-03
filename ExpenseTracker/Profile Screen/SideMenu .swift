//
//  SideMenu .swift
//  SignIn and SignUp
//
//  Created by Vaibhav Sharma on 24/07/24.
//

import SwiftUI

struct SideMenu_: View {
    @Binding var isshowing: Bool
    
    var body: some View {
        ZStack{
            if isshowing{
                Rectangle()
                    .opacity(0.3)
                    .ignoresSafeArea()
                    .onTapGesture { isshowing.toggle()}
            
            HStack{
                VStack(alignment: .leading,spacing: 32){
                    SideViewContent()
                }
                    .padding()
                    .frame(width: 270,alignment: .leading)
                    .background(Color.background)
                    
                    Spacer()
                }
            }
        }
        .frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .leading )
        .animation(.easeInOut,value: isshowing)
        
    }
}

#Preview {
    SideMenu_(isshowing: .constant(true))
}
