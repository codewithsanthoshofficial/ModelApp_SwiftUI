//
//  InputField.swift
//  ModelApp_SwiftUI
//
//  Created by Santhosh K on 21/02/26.
//

import SwiftUI

struct InputField: View {
    var icon:String
    var placeholder:String
    @Binding var text: String
    var isSecure:Bool = false
    var isError:Bool
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundStyle(isError ? .red : .gray)
                .frame(width: 30)
            
            if isSecure {
                SecureField(placeholder, text: $text)
            } else {
                TextField(placeholder, text: $text)
            }
            
            if isSecure {
                Image(systemName: "eye")
                    .foregroundStyle(.gray)
            }
        }
        .padding()
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 15)
                .stroke(isError ? Color.red.opacity(0.5): Color.clear, lineWidth: 1)
        )
        .shadow(color: .black.opacity(0.03), radius: 5, x:0, y:2)
        .padding(.horizontal, 20)
    }
}

#Preview {
    InputField(icon: "person", placeholder: "Username", text: .constant(""), isSecure: false, isError: false)
}
