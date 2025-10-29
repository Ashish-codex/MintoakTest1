//
//  Router.swift
//  MintoakTest1
//
//  Created by Ashish Prajapati on 29/10/25.
//

import Foundation
import SwiftUI

class Router: ObservableObject{

    enum EnumRouter: Hashable, Codable{
        case midScreen
        case filterScreen(index: Int)
    }
    
    
    @Published var navPath = NavigationPath()
    
    
    func navigate(to destination: EnumRouter){
        navPath.append(destination)
    }
    
    func navigateBack(){
        navPath.removeLast()
    }
}
