//
//  CGSafetyView.swift
//  VenturePrototype
//
//  Created by Philipp Sanktjohanser on 03.01.23.
//

import SwiftUI

struct CGSafetyView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Safety")
                .font(.title.bold())
                .padding(.bottom, 8)
            
            Group {
                Text("Violence and Threats")
                    .font(.title3.bold())
                
                Text("Venture takes threats and acts of violence seriously and any account associated with such activities will be indefinitely terminated.")
                    .font(.callout)
                
                Text("The depiction, glorification, support, encouragement of or reference to terrorism, violent actors, acts or extremist propaganda is prohibited, even for the purpose of denouncing such content.")
                    .font(.callout)
                
                Text("Threatening or promoting sexual violence or exploitation, especially child exploitation are strictly prohibited and may be reported accordingly.")
                    .font(.callout)
                
                Text("We may temporarily remove or preemptively suspend any account and associated content in exceptional circumstances, where an individual (1) has lost or is likely to loose control of their livestream, or (2) is likely to violate these guidelines. The likelihood may be weighted by us.")
                    .font(.callout)
            }
                
            Group {
                Text("Self-Destructive Behaviour")
                    .font(.title3.bold())
                    .padding(.top, 8)
                
                Text("Glorification, promotion or encouragement of self-harm and any activity that may endanger your life, lead to your physical harm or encourage others to engage in physically harmful behaviour is, without exceptions, prohibited. This includes the submission of dares that may harm the streamer or others.")
                    .font(.callout)
            }
            
            Group {
                Text("Minor Safety")
                    .font(.title3.bold())
                    .padding(.top, 8)
                
                Text("Any content or activity that endangers minors (defined as people under 18 by this policy), including child sexual abuse material (CSAM), is disallowed and may be reported accordingly.")
                    .font(.callout)
                
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .fixedSize(horizontal: false, vertical: true)
    }
}

struct CGSafetyView_Previews: PreviewProvider {
    static var previews: some View {
        CGSafetyView()
    }
}
