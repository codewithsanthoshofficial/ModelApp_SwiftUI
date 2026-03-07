//
//  SegmentButton.swift
//  ModelApp_SwiftUI
//
//  Created by Santhosh K on 21/02/26.
//

import SwiftUI

struct SegmentButton: View {
    @Binding var isLogin:Bool
    
    var body: some View {
        //Main Card
        VStack(spacing: 20) {
            //Custom Toggle (signup/ login)
            HStack(spacing: 0){
                Button("Login") {isLogin = true}
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 12)
                    .background(isLogin ? Color.white : Color.clear)
                    .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                    .shadow(radius: isLogin ? 2:0)
                
                Button("Sign Up") { isLogin = false}
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 12)
                    .background(!isLogin ? Color.white : Color.clear)
                    .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                    .shadow(radius: !isLogin ? 2:0)
            
            }
            .padding(5) // This is the small gap INSIDE the gray bar
            .background(Color.gray.opacity(0.1)) // The gray bar itself
            .cornerRadius(20)
            .padding(.horizontal, 10)
        }
    }
}



#Preview("Static Preview") {
    SegmentButton(isLogin: .constant(false))
}

#Preview("Interactive Preview") {
    struct PreviewWrapper: View {
        @State private var isLogin = false
        var body: some View {
            SegmentButton(isLogin: $isLogin)
                .padding()
                .background(Color(.systemGroupedBackground))
        }
    }
    return PreviewWrapper()
}



//// Helper to provide a mutable Binding in previews
//private struct StatefulPreviewWrapper<Value, Content: View>: View {
//    @State private var value: Value
//    private let content: (Binding<Value>) -> Content
//
//    init(_ initialValue: Value, @ViewBuilder content: @escaping (Binding<Value>) -> Content) {
//        _value = State(wrappedValue: initialValue)
//        self.content = content
//    }
//
//    var body: some View {
//        content($value)
//    }
//}
//#Preview("Static Preview") {
//    SegmentButton(isLogin: .constant(true))
//}
//
//#Preview("Interactive Preview") {
//    StatefulPreviewWrapper(false) { binding in
//        SegmentButton(isLogin: binding)
//            .padding()
//            .background(Color(.systemGroupedBackground))
//    }
//}

