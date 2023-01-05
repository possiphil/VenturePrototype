//
//  CGCivilityView.swift
//  VenturePrototype
//
//  Created by Philipp Sanktjohanser on 03.01.23.
//

import SwiftUI

struct CGCivilityView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Civility")
                .font(.title.bold())
                .padding(.bottom, 8)
            
            Group {
                Text("Harassment")
                    .font(.title3.bold())
                
                Text("Harassment, all of its manifestations, and any activity or content that encourages or promotes discrimination, denigration, harassment, or violence based on race, ethnicity, color, caste, national origin, immigration status, religion, sex, gender, gender identity, sexual orientation, disability, serious medical condition, veteran status, age and similar characteristics is prohibited.")
                    .font(.callout)
            }
            
            Group {
                Text("Privacy")
                    .font(.title3.bold())
                    .padding(.top, 8)
                
                Text("Without permission, sharing of content that may reveal private personal information about individuals or their private property is prohibited.")
                    .font(.callout)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .fixedSize(horizontal: false, vertical: true)
    }
}

struct CGCivilityView_Previews: PreviewProvider {
    static var previews: some View {
        CGCivilityView()
    }
}
