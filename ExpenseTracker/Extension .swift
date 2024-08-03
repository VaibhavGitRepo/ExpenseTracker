//
//  Extension .swift
//  ExpenseTracker
//
//  Created by Vaibhav Sharma on 21/07/24.
//

import Foundation
import SwiftUI

extension Color{
    static let Background = Color("Background")
    static let Icon = Color("Icon")
    static let Text = Color("Text")
    static let systemBackground = Color(uiColor: .systemBackground)
}

extension DateFormatter{
    static let allNumericUSA: DateFormatter = {
        print("Initailizing DateFormatter..")
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        
        return formatter
    }()
}

extension String{
    func dateParsed() -> Date {
        guard let parsedDate = DateFormatter.allNumericUSA.date(from: self) else {return Date() }
        return parsedDate 
    }
}
struct CustomButton: View {
    var title: String
    var backgroundColor: LinearGradient = LinearGradient(colors: [Color("Teal"),Color("Pink")], startPoint: .leading, endPoint: .trailing)
    var width: CGFloat
    var height: CGFloat
    var cornerRadius: CGFloat
    var size: CGFloat
    //var Fonttype: String
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .foregroundColor(.white)
                .frame(width: width, height: height)
                .background(backgroundColor)
                .cornerRadius(cornerRadius)
                .font(Font.system(size: size))
        }
        //.padding(.horizontal, 20)
    }
}

struct SocalLoginButton: View {
    var image: Image
    var text: Text
    var backgroundColor: LinearGradient = LinearGradient(colors: [Color("Teal"),Color("Pink")], startPoint: .leading, endPoint: .trailing)
    
    var body: some View {
        Button{
            print(text)
        }label: {
            HStack {
                image
                    .padding(.horizontal)
                Spacer()
                text
                    .font(.title2)
                Spacer()
            }
            .padding()
            .frame(width: 365,height: 57)
            .background(LinearGradient(gradient: Gradient(colors:[Color(.systemTeal),Color(.systemPurple)]), startPoint: .leading, endPoint: .trailing))
            .cornerRadius(50)
            .shadow(color: Color.black.opacity(0.08), radius: 60, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 16)
        }
    }
}

extension Date: Strideable{
    func  formatted() -> String {
        return self.formatted(.dateTime.year().month().day())
    }
}

extension Double {
    func roundedto2digits() -> Double {
        return (self * 100).rounded() / 100 
    }
}

struct User: Identifiable,Codable{
    let id: String
    let fullname : String
    let email : String
    
    var initials: String {
        let formattor = PersonNameComponentsFormatter()
        if let components = formattor.personNameComponents(from: fullname){
            formattor.style = .abbreviated
            return formattor.string(from: components)
        }
        return ""
    }
}
