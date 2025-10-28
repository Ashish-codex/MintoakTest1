//
//  ModelFilterData.swift
//  MintoakTest
//
//  Created by Ashish Prajapati on 17/10/25.
//

import Foundation


struct ModelFilterData: Codable {
    let status, message, errorCode: String
    let filterData: [FilterData]
    
    // MARK: - FilterData
    struct FilterData: Codable {
        let id = UUID().uuidString
        let cif, companyName: String
        let accountList, brandList, locationList: [String]
        let hierarchy: [Hierarchy]

        enum CodingKeys: String, CodingKey {
            case cif = "Cif"
            case companyName, accountList, brandList, locationList, hierarchy
        }
    }

    // MARK: - Hierarchy
    struct Hierarchy: Codable {
        let accountNumber: String
        let brandNameList: [BrandNameList]
    }

    // MARK: - BrandNameList
    struct BrandNameList: Codable {
        let brandName: String
        let locationNameList: [LocationNameList]
    }

    // MARK: - LocationNameList
    struct LocationNameList: Codable {
        let locationName: String
        let merchantNumber: [MerchantNumber]
    }

    // MARK: - MerchantNumber
    struct MerchantNumber: Codable {
        let mid: String
        let outletNumber: [String]
    }

}

