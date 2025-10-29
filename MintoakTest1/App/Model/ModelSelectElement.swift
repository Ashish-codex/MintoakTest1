//
//  ModelSelectElement.swift
//  MintoakTest1
//
//  Created by Ashish Prajapati on 17/10/25.
//

import Foundation

struct ModelSelectElement {
    let id = UUID().uuidString
    var name: String
    var isSelected: Bool
}


enum EnumCategoryType:String{
    case account, brand, location, none
}



