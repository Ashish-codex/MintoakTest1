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
                    ForEach(Array(vmFilter.arrAccountCategory.enumerated()), id: \.offset ) { (index, data) in
                        
                        Button {
                            vmFilter.arrAccountCategory[index].isSelected.toggle()
                        } label: {
                            HStack {
                                Image(systemName: vmFilter.arrAccountCategory[index].isSelected ? "checkmark.square.fill" : "square")
                                    .foregroundColor(.orange)
                                Text(vmFilter.arrAccountCategory[index].name)
                                    .foregroundColor(.primary)
                            }
                        }

                    }
                }
                
                
                if vmFilter.categoryType == .brand{
                    
                    ForEach(Array(vmFilter.arrBrandCategory.enumerated()), id: \.offset ) { (index, data) in
                        
                        Button {
                            vmFilter.arrBrandCategory[index].isSelected.toggle()
                        } label: {
                            HStack {
                                Image(systemName: vmFilter.arrBrandCategory[index].isSelected ? "checkmark.square.fill" : "square")
                                    .foregroundColor(.orange)
                                Text(vmFilter.arrBrandCategory[index].name)
                                    .foregroundColor(.primary)
                            }
                        }

                    }
                }
                
                
                
                if vmFilter.categoryType == .location{
                    
                    ForEach(Array(vmFilter.arrLocationCategory.enumerated()), id: \.offset ) { (
                        index,
                        data
                    ) in
                        
                        Button {
                            vmFilter.arrLocationCategory[index].isSelected.toggle()
                        } label: {
                            HStack {
                                Image(systemName: vmFilter.arrLocationCategory[index].isSelected ? "checkmark.square.fill" : "square")
                                    .foregroundColor(.orange)
                                Text(vmFilter.arrLocationCategory[index].name)
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
                vmFilter.updateSelectedCategoryElementCount()
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
        })
        .onDisappear {
            vmFilter.showSheet = false
        }
    }

    
    private var allSelected: Bool {
        if vmFilter.categoryType == .account{
            return vmFilter.arrAccountCategory.allSatisfy { $0.isSelected }
        }
        
        if vmFilter.categoryType == .brand{
            return vmFilter.arrBrandCategory.allSatisfy { $0.isSelected }
        }
        
        if vmFilter.categoryType == .location{
            return vmFilter.arrLocationCategory.allSatisfy { $0.isSelected }
        }
        
        return true
    }
    
    private func toggleSelectAll() {
        let newState = !allSelected
        
        if vmFilter.categoryType == .account{
            for i in vmFilter.arrAccountCategory.indices{
                vmFilter.arrAccountCategory[i].isSelected = newState
            }
        }
        
        if vmFilter.categoryType == .brand{
            for i in vmFilter.arrBrandCategory.indices{
                vmFilter.arrBrandCategory[i].isSelected = newState
            }
        }
        
        if vmFilter.categoryType == .location{
            for i in vmFilter.arrLocationCategory.indices{
                vmFilter.arrLocationCategory[i].isSelected = newState
            }
        }
    }
}



#Preview {
    SelectLocationView()
}
