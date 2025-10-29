//
//  MintoakTest1App.swift
//  MintoakTest1
//
//  Created by Ashish Prajapati on 17/10/25.
//

import SwiftUI

@main
struct MintoakTest1App: App {
    
    @StateObject var vm = FilterViewModel()
    @ObservedObject var router = Router()
    
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $router.navPath){
                HomeView()
                    .navigationDestination(for: Router.EnumRouter.self, destination: { destination in
                        switch destination {
                        case .midScreen: MIDListView()
                        case .filterScreen(let index): FilterView(selectedIndex: index)
                        }
                    })
                    .preferredColorScheme(.light)
            }
            .environmentObject(vm)
            .environmentObject(router)
        }
    }
}
