//
//  MIDListView.swift
//  MintoakTest1
//
//  Created by Ashish Prajapati on 17/10/25.
//

import SwiftUI

struct MIDListView: View {
    @EnvironmentObject var vmFilter: FilterViewModel
    
    var body: some View {
        
        VStack{
            
            Text("List of MID's")
                .frame(maxWidth: .infinity, alignment: .center)
                .font(.headline)
                
            
            if !vmFilter.arrMID.isEmpty{
                List{
                    ForEach(vmFilter.arrMID, id: \.self) { data in
                        
                        Text("\(data)")
                    }
                }
            }
            else{
                Text("No MID's found")
                    .frame(
                        maxWidth: .infinity,
                        maxHeight: .infinity,
                        alignment: .center
                    )
                    .font(.subheadline)
            }
            
            
        }
    }
}

#Preview {
    MIDListView()
}
