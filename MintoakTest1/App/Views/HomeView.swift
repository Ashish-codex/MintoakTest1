//
//  HomeView.swift
//  MintoakTest1
//
//  Created by Ashish Prajapati on 17/10/25.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var vm: FilterViewModel
    @EnvironmentObject var router: Router
    
    var body: some View {
        
        VStack{
            Text("Companies")
                .frame(maxWidth: .infinity, alignment: .center)
                .font(.headline)
                .padding(.top, 15)
            
            
            List{
                
                ForEach( Array(vm.arrFilterData.enumerated()), id: \.offset) { (index, data) in
                    
                    Button {
                        router.navigate(to: .filterScreen(index: index))
                    } label: {
                        HStack {
                            Text("\(data.companyName)")
                                .foregroundColor(.black)

                            Spacer()

                            Image(systemName: "chevron.right")
                                .foregroundColor(.gray)
                        }
                        .padding(.vertical, 7)
                    }

                }
            
            }
            
        }

    }
}

#Preview {
    HomeView()
}
