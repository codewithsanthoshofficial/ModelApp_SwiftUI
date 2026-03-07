//
//  DetailView.swift
//  ModelApp_SwiftUI
//
//  Created by Santhosh K on 25/02/26.
//

import SwiftUI

struct DetailView: View {
    
    let item : MenuItem
    
    var body: some View {
        Text("Details for \(item.title)")
                    .navigationTitle(item.title)
                    .navigationBarTitleDisplayMode(.inline)
    }
}

//#Preview {
//    DetailView()
//}
