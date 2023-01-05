//
//  SearchBar.swift
//  VenturePrototype
//
//  Created by Philipp Sanktjohanser on 04.01.23.
//

import Combine
import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    
    var body: some View {
        HStack {
            TextField("Search", text: $text)
                .padding(8)
                .padding(.horizontal, 24)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .onReceive(Just(text)) { newValue in
                    let filtered = newValue.filter { Set("0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ.-_").contains($0) }
                    if filtered != newValue {
                        self.text = filtered
                    }
                }
                .overlay(
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 8)
                    }
                )
        }
        .padding(.horizontal, 4)
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar(text: .constant(""))
    }
}
