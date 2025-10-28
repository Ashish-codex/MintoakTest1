//
//  MintoakTest1App.swift
//  MintoakTest1
//
//  Created by Ashish Prajapati on 17/10/25.
//

import SwiftUI

@main
struct MintoakTest1App: App {
    var body: some Scene {
        WindowGroup {
            NavigationStack{
                HomeView()
                    .preferredColorScheme(.light)
            }
        }
    }
}
