//
//  SelectLocationView.swift
//  MintoakTest
//
//  Created by Ashish Prajapati on 17/10/25.
//

import SwiftUI

struct SelectLocationView: View {
    
    @EnvironmentObject var vmFilter: FilterViewModel
    @Environment(\.dismiss) var dismiss
    @State private var searchText = ""

    
    var body: some View {
        VStack(spacing: 12) {
            HStack {
                Text("Select Locations")
                    .font(.headline)
                Spacer()
                Button(action: { dismiss() }) {
                    Image(systemName: "xmark")
                        .foregroundColor(.gray)
                }
            }
            .padding(.horizontal)
            .padding(.top, 10)
            
            // Search bar
//            TextField("Search for \(vmFilter.selecedElement)", text: $searchText)
//                .padding(10)
//                .background(Color(.systemGray6))
//                .cornerRadius(8)
//                .padding(.horizontal)
            
            // Select All + Clear
            HStack {
                Button(action: toggleSelectAll) {
                    HStack {
                        Image(systemName: allSelected ? "checkmark.square.fill" : "square")
                            .foregroundColor(.orange)
                        Text("Select All")
                    }
                }
                Spacer()

            }
            .padding(.horizontal)
            
            // List of locations
            List {
                
                if vmFilter.categoryType == .account{
                    ForEach(Array(vmFilter.arrTempAccountCategory.enumerated()), id: \.offset ) { (index, data) in
                        
                        Button {
                            vmFilter.arrTempAccountCategory[index].isSelected.toggle()
                        } label: {
                            HStack {
                                Image(systemName: vmFilter.arrTempAccountCategory[index].isSelected ? "checkmark.square.fill" : "square")
                                    .foregroundColor(.orange)
                                Text(vmFilter.arrTempAccountCategory[index].name)
                                    .foregroundColor(.primary)
                            }
                        }

                    }
                }
                
                
                if vmFilter.categoryType == .brand{
                    
                    ForEach(Array(vmFilter.arrTempBrandCategory.enumerated()), id: \.offset ) { (index, data) in
                        
                        Button {
                            vmFilter.arrTempBrandCategory[index].isSelected.toggle()
                        } label: {
                            HStack {
                                Image(systemName: vmFilter.arrTempBrandCategory[index].isSelected ? "checkmark.square.fill" : "square")
                                    .foregroundColor(.orange)
                                Text(vmFilter.arrTempBrandCategory[index].name)
                                    .foregroundColor(.primary)
                            }
                        }

                    }
                }
                
                
                
                if vmFilter.categoryType == .location{
                    
                    ForEach(Array(vmFilter.arrTempLocationCategory.enumerated()), id: \.offset ) { (
                        index,
                        data
                    ) in
                        
                        Button {
                            vmFilter.arrTempLocationCategory[index].isSelected.toggle()
                        } label: {
                            HStack {
                                Image(systemName: vmFilter.arrTempLocationCategory[index].isSelected ? "checkmark.square.fill" : "square")
                                    .foregroundColor(.orange)
                                Text(vmFilter.arrTempLocationCategory[index].name)
                                    .foregroundColor(.primary)
                            }
                        }

                    }
                }
                
            }
            .listStyle(.plain)
            
            // Apply button
            Button(action: {
                dismiss()
                vmFilter.setTempOrMainCategoryArray(categoryType: vmFilter.categoryType, isTemp: false)
                vmFilter.onApplyFiltersInPriorityOrder()

            }) {
                Text("APPLY")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(8)
            }
            .padding(.horizontal)
            .padding(.bottom, 10)
        }
        .padding(.top, 20)
        .onAppear(perform: {
            print("categrory type = \(vmFilter.categoryType)")
            vmFilter.setTempOrMainCategoryArray(categoryType: vmFilter.categoryType, isTemp: true)
        })
        .onDisappear {
            vmFilter.showSheet = false
        }
    }

    
    private var allSelected: Bool {
        if vmFilter.categoryType == .account{
            return vmFilter.arrTempAccountCategory.allSatisfy { $0.isSelected }
        }
        
        if vmFilter.categoryType == .brand{
            return vmFilter.arrTempBrandCategory.allSatisfy { $0.isSelected }
        }
        
        if vmFilter.categoryType == .location{
            return vmFilter.arrTempLocationCategory.allSatisfy { $0.isSelected }
        }
        
        return true
    }
    
    private func toggleSelectAll() {
        let newState = !allSelected
        
        if vmFilter.categoryType == .account{
            for i in vmFilter.arrTempAccountCategory.indices{
                vmFilter.arrTempAccountCategory[i].isSelected = newState
            }
        }
        
        if vmFilter.categoryType == .brand{
            for i in vmFilter.arrTempBrandCategory.indices{
                vmFilter.arrTempBrandCategory[i].isSelected = newState
            }
        }
        
        if vmFilter.categoryType == .location{
            for i in vmFilter.arrTempLocationCategory.indices{
                vmFilter.arrTempLocationCategory[i].isSelected = newState
            }
        }
    }
}



#Preview {
    SelectLocationView()
}
