//
//  SearchView.swift
//  VenturePrototype
//
//  Created by Philipp Sanktjohanser on 04.01.23.
//

import SwiftUI

struct SearchView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var vm = SearchVM()
    
    @FocusState private var textFieldFocused: Bool
    
    var body: some View {
        VStack {
            HStack(spacing: 0) {
                Image(systemName: "chevron.left")
                    .frame(width: 44, height: 44)
                    .onTapGesture {
                        dismiss()
                    }
                
                SearchBar(text: $vm.searchText)
                    .focused($textFieldFocused)
            }
            .padding(.trailing)
            
            ScrollView(showsIndicators: false) {
                LazyVStack {
                    ForEach(vm.searchableUsers) { user in
                        NavigationLink {
                            ProfileView(user: user)
                        } label: {
                            UserRowView(user: user)
                        }
                    }
                }
            }
        }
        .toolbar(.hidden)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                textFieldFocused = true
            }
        }
        .onTapGesture {
            textFieldFocused = false
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            SearchView()
        }
    }
}
