//
//  CGSensitiveContentView.swift
//  VenturePrototype
//
//  Created by Philipp Sanktjohanser on 03.01.23.
//

import SwiftUI

struct CGSensitiveContentView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Sensitive Content")
                .font(.title.bold())
                .padding(.bottom, 8)
            
            Group {
                Text("Violence")
                    .font(.title3.bold())
                
                Text("Content exclusively focusing on extreme or unjustified gore and violence is prohibited.")
                    .font(.callout)
            }
            
            Group {
                Text("Nudity")
                    .font(.title3.bold())
                    .padding(.top, 8)
                
                Text("Nudity and sexually explicit content or activities are prohibited. This also applies for sexually suggestive activities or content and linking or soliciting of such, although they may be allowed in educational contexts or for pre-approved licensed content.")
                    .font(.callout)
            }
            
            Group {
                Text("Gambling")
                    .font(.title3.bold())
                    .padding(.top, 8)
                
                Text("Promoting or depicting gambling services is not allowed.")
                    .font(.callout)
            }
            
            Group {
                Text("Regulated Goods")
                    .font(.title3.bold())
                    .padding(.top, 8)
                
                Text("We do not allow the depiction, promotion, or trade of firearms, ammunition, firearm accessories, or explosive weapons. Instructions on how to manufacture weapons is also not permitted. An exception may be made in educational contexts.")
                    .font(.callout)
                
                Text("The depiction, promotion, or trade of drugs and other controlled substances is prohibited.")
                    .font(.callout)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .fixedSize(horizontal: false, vertical: true)
    }
}

struct CGSensitiveContentView_Previews: PreviewProvider {
    static var previews: some View {
        CGSensitiveContentView()
    }
}
