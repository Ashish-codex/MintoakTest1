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
    
    var body: some Scene {
        WindowGroup {
            NavigationStack{
                HomeView()
                    .preferredColorScheme(.light)
            }
            .environmentObject(vm)
        }
    }
}
