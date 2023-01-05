//
//  CGAuthenticityView.swift
//  VenturePrototype
//
//  Created by Philipp Sanktjohanser on 03.01.23.
//

import SwiftUI

struct CGAuthenticityView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Authenticity")
                .font(.title.bold())
                .padding(.bottom, 8)
            
            Group {
                Text("Impersonation")
                    .font(.title3.bold())
                
                Text("Impersonating any individual or organization is not permitted.")
                    .font(.callout)
            }
            
            Group {
                Text("Integrity")
                    .font(.title3.bold())
                    .padding(.top, 8)
                
                Text("Any content or activity that violates the integrity of our service or another user’s experience or devices is prohibited.")
                    .font(.callout)
            }
            
            Group {
                Text("Misinformation")
                    .font(.title3.bold())
                    .padding(.top, 8)
                
                Text("Sharing harmful misinformation is disallowed. Accounts dedicated to persistently sharing harmful misinformation may be suspended.")
                    .font(.callout)
            }
            
            Group {
                Text("Termination Evasion")
                    .font(.title3.bold())
                    .padding(.top, 8)
                
                Text("Any attempt to circumvent an account termination by any kind of inappropriate method will result in additional enforcement against your account(s), up to an indefinite termination.")
                    .font(.callout)
                
                Text("You are expected to effort to remove any suspended user from your broadcast, it is prohibited to knowingly feature or advertise a suspended user.")
                    .font(.callout)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .fixedSize(horizontal: false, vertical: true)
    }
}

struct CGAuthenticityView_Previews: PreviewProvider {
    static var previews: some View {
        CGAuthenticityView()
    }
}
