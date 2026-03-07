//
//  HomeViewModel.swift
//  ModelApp_SwiftUI
//
//  Created by Santhosh K on 21/02/26.
//

import SwiftUI
import Combine


//@MainActor
//class HomeViewModel: ObservableObject {
//
//    @Published var homePageList:[String] = []
//
//    init() {
//        self.addList()
//    }
//
//    func addList() {
//        self.homePageList.append("API Call")
//    }
//
//}
//


final class HomeViewModel : ObservableObject {
    
    @Published var sections: [MenuSection]
    
    init(sections: [MenuSection] = HomeViewModel.defaultsections) {
        self.sections = sections
    }
}

private extension HomeViewModel {
    static let defaultsections: [MenuSection] = [
        
        MenuSection(
            title: "API Call",
            items: [ MenuItem(title: "News API"),
                     MenuItem(title: "Stack API")
                   ]
        ),
        MenuSection(
            title: "API Call - Combine",
            items: [ MenuItem(title: "News API"),
                    ]
        )
    ]
    
}
