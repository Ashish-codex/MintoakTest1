//
//  FilterView.swift
//  MintoakTest
//
//  Created by Ashish Prajapati on 17/10/25.
//

import SwiftUI

struct FilterView: View {
    
    @EnvironmentObject var vmFilter: FilterViewModel
    @State private var path = NavigationPath()
    
    let selectedIndex: Int
    init(selectedIndex: Int) {
        self.selectedIndex = selectedIndex
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Text("Apply Filter")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .padding(.top, 16)
                
                // Selected company
                Button(action: {
                    vmFilter.onApplyCategoryFilter()
                }) {
                    Text("\(vmFilter.currentSelectedCompany?.companyName ?? "")")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(8)
                }
                .padding(.horizontal)
                .padding(.bottom, 10)
                
                // Summary badges
                HStack(spacing: 10) {
                    FilterTagView(title: "Acc No.: \(vmFilter.selectedAccount)")
                    FilterTagView(title: "Brand: \(vmFilter.selectedBrand)")
                    FilterTagView(title: "Location: \(vmFilter.selectedLocations)")
                    Spacer()
                    Button("Clear") {
                        vmFilter.clearCategoryFilter()
                    }
                    .foregroundColor(.gray)
                }
                .padding(.horizontal)
                
                // Filter rows
                VStack(alignment: .leading, spacing: 16) {
                    
                    FilterRow(
                        vmFilter: vmFilter,
                        title: "Select Account Number",
                        value: "\(vmFilter.selectedAccount)",
                        categoryType: .account
                    )
                    FilterRow(
                        vmFilter: vmFilter,
                        title: "Select Brand",
                        value: "\(vmFilter.selectedBrand)",
                        categoryType: .brand
                    )
                    FilterRow(
                        vmFilter: vmFilter,
                        title: "Select Locations",
                        value: "\(vmFilter.selectedLocations)",
                        categoryType: .location
                    )
                }
                .padding(.horizontal)
                
                Spacer()
                
                // Apply button
                
                
                
                NavigationLink {
                    MIDListView()
                        .environmentObject(vmFilter)
                } label: {
                    
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
//                
//                Button(action: {
//                    vmFilter.onApplyCategoryFilter()
//                    path.append("MIDListView")
//                }) {
//                    Text("APPLY")
//                        .font(.headline)
//                        .foregroundColor(.white)
//                        .frame(maxWidth: .infinity)
//                        .padding()
//                        .background(Color.blue)
//                        .cornerRadius(8)
//                }
//                .padding(.horizontal)
//                .padding(.bottom, 10)
            }
            .sheet(isPresented: $vmFilter.showSheet) {
                SelectLocationView()
                    .environmentObject(vmFilter)
                    
            }
            
        }
//        .navigationDestination(for: String.self, destination: { val in
//            if val == "MIDListView"{
//                MIDListView()
//            }
//        })
        .onAppear {
            vmFilter.updateSelectedCompany(index: selectedIndex)
            vmFilter.setupCategoryElements()
            vmFilter.onApplyCategoryFilter()
        }
//        .environmentObject(vmFilter)
        
        
    }
    
    
    struct FilterTagView: View {
        let title: String
        
        var body: some View {
            Text(title)
                .font(.subheadline)
                .foregroundColor(.white)
                .padding(.vertical, 6)
                .padding(.horizontal, 10)
                .background(Color.blue)
                .cornerRadius(8)
        }
    }

    struct FilterRow: View {
        var vmFilter: FilterViewModel
        let title: String
        let value: String
        let categoryType: EnumCategoryType
        
        var body: some View {
            Button(action: {
                vmFilter.showSheet = true
                vmFilter.categoryType = categoryType
                
                
            }) {
                HStack {
                    Text(title)
                        .foregroundColor(.primary)
                    Spacer()
                    Text(value)
                        .foregroundColor(.gray)
                    Image(systemName: "chevron.right")
                        .foregroundColor(.gray)
                }
                .padding(.vertical, 8)
                .contentShape(Rectangle())
            }
        }
    }

}


#Preview {
    FilterView(selectedIndex: 0)
}
