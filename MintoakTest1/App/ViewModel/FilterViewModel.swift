//
//  FilterViewModel.swift
//  MintoakTest
//
//  Created by Ashish Prajapati on 17/10/25.
//

import Foundation

class FilterViewModel: ObservableObject{
    
    private var modelFilterData: ModelFilterData?
    @Published var arrFilterData: [ModelFilterData.FilterData] = []
    
    @Published var selectedAccount = 0
    @Published var selectedBrand = 0
    @Published var selectedLocations = 0
    @Published var selecedElement = ""
    @Published var showSheet = false
    
    @Published var currentSelectedCompany: ModelFilterData.FilterData?
    @Published var categoryType: EnumCategoryType = .none
    @Published var arrAccountCategory: [ModelSelectElement] = []
    @Published var arrBrandCategory: [ModelSelectElement] = []
    @Published var arrLocationCategory: [ModelSelectElement] = []
    @Published var arrMID: [String] = []
    
    
    // Priority order: first element = priority 1, second = priority 2, and so on
    @Published var arrPrioritizeCategory: [EnumCategoryType] = []
    
    
    init(){
        loadJsonData(fileName: "Filter_JSON_File")
    }
    
    
    
    func updateSelectedCompany(index: Int){
        currentSelectedCompany = arrFilterData[index]
        
        selectedAccount = currentSelectedCompany?.accountList.count ?? 0
        selectedBrand = currentSelectedCompany?.brandList.count ?? 0
        selectedLocations = currentSelectedCompany?.locationList.count ?? 0
    }
    
    func updateSelectedCategoryElementCount(){
        selectedAccount = arrAccountCategory.filter({ $0.isSelected }).count
        selectedBrand = arrBrandCategory.filter({ $0.isSelected }).count
        selectedLocations = arrLocationCategory.filter({ $0.isSelected }).count
    }
    
    
    func clearCategoryFilter(){
        selectedAccount = currentSelectedCompany?.accountList.count ?? 0
        selectedBrand = currentSelectedCompany?.brandList.count ?? 0
        selectedLocations = currentSelectedCompany?.locationList.count ?? 0
        
        setupCategoryElements()
        arrPrioritizeCategory.removeAll()
    }
    
    
    // Apply filters step-by-step based on priority array
    func onApplyFiltersInPriorityOrder(){
        arrPrioritizeCategory.append(categoryType)
        var filteredHierarchy = currentSelectedCompany?.hierarchy ?? []
        
        for category in arrPrioritizeCategory{
            
            switch category {
                
            case .account:
                let selectedAccounts = arrAccountCategory.filter({ $0.isSelected }).map { $0.name }
                if !selectedAccounts.isEmpty {
                    filteredHierarchy = filteredHierarchy.filter { selectedAccounts.containsIgnoringWhitespace($0.accountNumber) }
                }
                break
                
                
            case .brand:
                let selectedBrands = arrBrandCategory.filter({ $0.isSelected }).map { $0.name }
                if !selectedBrands.isEmpty {
                    filteredHierarchy = filteredHierarchy.compactMap { account in
                    
                        let matchingBrands = account.brandNameList.filter { selectedBrands.containsIgnoringWhitespace($0.brandName) }
                        
                        guard !matchingBrands.isEmpty else {
                            return ModelFilterData.Hierarchy(accountNumber: "", brandNameList: [])
                        }
                        
                        return ModelFilterData.Hierarchy(accountNumber: account.accountNumber, brandNameList: matchingBrands)
                         
                    }
                }
                break
                
            case .location:
                let selectedLocations = arrLocationCategory.filter({ $0.isSelected }).map { $0.name }
                
                if !selectedLocations.isEmpty {
                    
                    // Open account list array
                    filteredHierarchy = filteredHierarchy.compactMap { account in
                        
                        // Open brand list array
                        let filteredBrands = account.brandNameList.compactMap { brand in
                            
                            // if matchingLocations found
                            let matchingLocations = brand.locationNameList.filter { selectedLocations.containsIgnoringWhitespace($0.locationName) }
                            
                            guard !matchingLocations.isEmpty else {
                                return ModelFilterData.BrandNameList(brandName: "", locationNameList: [])
                            }
                            return ModelFilterData.BrandNameList(brandName: brand.brandName, locationNameList: matchingLocations)
                            
                        }
                        
                        guard !filteredBrands.isEmpty else {
                            return ModelFilterData.Hierarchy(accountNumber: "", brandNameList: [])
                        }
                        
                        return ModelFilterData
                            .Hierarchy(
                                accountNumber: account.accountNumber,
                                brandNameList: filteredBrands
                            )
                    }
                    
                }
                
                break
                
            case .none:
                break
            }
            
            updateAvailableOptions(from: filteredHierarchy, excluding: category)
        }
        
        
    }
    
    // After applying priority filter, update the existing list that is available on screen
    private func updateAvailableOptions(
        from filtered: [ModelFilterData.Hierarchy],
        excluding: EnumCategoryType
    ) {
        if excluding != .account {
            let availableAccounts = filtered.map { $0.accountNumber }
//                .unique()
            
            arrAccountCategory = mergeUpdatedNameAndPreserveSelection(arrExisting: arrAccountCategory, arrUpdatedNames: availableAccounts)
        }
        if excluding != .brand {
            let availableBrands = filtered.flatMap { $0.brandNameList.map { $0.brandName } }
//                .unique()
            arrBrandCategory = mergeUpdatedNameAndPreserveSelection(arrExisting: arrBrandCategory, arrUpdatedNames: availableBrands)
        }
        if excluding != .location {
            let availableLocations = filtered.flatMap { $0.brandNameList.flatMap { $0.locationNameList.map { $0.locationName } } }
//                .unique()
            arrLocationCategory = mergeUpdatedNameAndPreserveSelection(arrExisting: arrLocationCategory, arrUpdatedNames: availableLocations)
        }
    }

    
    /* Merge the updated names(options) into existing FilterItem array while preserving .isSelected.
     Basically here we have two array 1.arrExisting(which is existing arrya that contains .isSelected)
     2.arrUpdatedNames(which having updated names or options that is getting form main hierarchy array
    */
    private func mergeUpdatedNameAndPreserveSelection(arrExisting: [ModelSelectElement], arrUpdatedNames: [String]) -> [ModelSelectElement] {
        let existingMap = Dictionary(uniqueKeysWithValues: arrExisting.map { ($0.name.trimmed(), $0.isSelected) })
        
        return arrUpdatedNames.map { name in
            let trimmed = name.trimmed()
            let previouslySelected = existingMap[trimmed] ?? false
            return ModelSelectElement(name: name, isSelected: previouslySelected)
        }
    }
    
    
    
    func setupCategoryElements(){
        
        /// Account Category
        arrAccountCategory.removeAll()
        currentSelectedCompany?.accountList.forEach({ data in
            arrAccountCategory.append(ModelSelectElement(name: data, isSelected: true))
        })
        
        /// Brand Category
        arrBrandCategory.removeAll()
        currentSelectedCompany?.brandList.forEach({ data in
            arrBrandCategory.append(ModelSelectElement(name: data, isSelected: true))
        })
        
        /// Location Category
        arrLocationCategory.removeAll()
        currentSelectedCompany?.locationList.forEach({ data in
            arrLocationCategory.append(ModelSelectElement(name: data, isSelected: true))
        })
    }
    
    func onApplyCategoryFilter(){
        
        arrMID.removeAll()
        
        for account in (currentSelectedCompany?.hierarchy ?? []) {
            guard arrAccountCategory
                .contains(where: { $0.isSelected && $0.name == account.accountNumber }) else {
                continue
            }
            
            for brand in account.brandNameList {
                guard arrBrandCategory.contains(where: { $0.isSelected && $0.name.lowercased().trimmingCharacters(in: .whitespaces) == brand.brandName.lowercased().trimmingCharacters(in: .whitespaces) }) else { continue }
                
                for loc in brand.locationNameList{
                    guard arrLocationCategory.contains(where: {  $0.isSelected && $0.name.lowercased().trimmingCharacters(in: .whitespaces) == loc.locationName.lowercased().trimmingCharacters(in: .whitespaces) }) else { continue }
                    
                    
                    for merchant in loc.merchantNumber{
                        arrMID.append(merchant.mid)
                    }
                    
                }
            }
        }
    }
    
    
    private func loadJsonData(fileName:String){
        
        do {
            
            if let path = Bundle.main.path(forResource: fileName, ofType: ".txt"){
                
                if let data = try String(contentsOfFile: path).data(using: .utf8){
                    
                    modelFilterData = try JSONDecoder().decode(ModelFilterData.self, from: data)
                    arrFilterData = modelFilterData?.filterData ?? []
                    
//                    print("Model Data = \(modelFilterData)")
                    
                } else{
                    print("Failed: Can not read from file path to data")
                    
                }
                
            }
            else {
                print("Failed: Path doesn't exist")
            }
            
            
        } catch let err {
            print("Catch Error: \(err.localizedDescription)")
            
        }

        
    }
}
