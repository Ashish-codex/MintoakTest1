//
//  HomeView.swift
//  MintoakTest1
//
//  Created by Ashish Prajapati on 17/10/25.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject var vm = FilterViewModel()
    
    var body: some View {
        
        VStack{
            Text("Companies")
                .frame(maxWidth: .infinity, alignment: .center)
                .font(.headline)
                .padding(.top, 15)
            
            
            List{
                
                ForEach( Array(vm.arrFilterData.enumerated()), id: \.offset) { (index, data) in
                    NavigationLink {
                        FilterView(selectedIndex: index)
                            .environmentObject(vm)
                    } label: {
                        Text("\(data.companyName)")
                    }
                }
            
            }
            
        }
//        .environmentObject(vm)
    }
}

#Preview {
    HomeView()
}
