//
//  HomeModel.swift
//  ModelApp_SwiftUI
//
//  Created by Santhosh K on 25/02/26.
//

import SwiftUI


struct MenuItem: Hashable, Identifiable {
    let id: UUID
    let title:String
    
    init(id:UUID = UUID(), title:String) {
        self.id = id
        self.title = title
    }
}


struct MenuSection: Identifiable {
    let id : UUID
    let title:String
    let items:[MenuItem]
    
    init(id:UUID = UUID(), title:String, items:[MenuItem]) {
        self.id = id
        self.title = title
        self.items = items
    }
}
