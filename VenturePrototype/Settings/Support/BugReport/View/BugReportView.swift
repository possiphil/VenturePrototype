//
//  BugReportView.swift
//  VenturePrototype
//
//  Created by Philipp Sanktjohanser on 02.01.23.
//

import SwiftUI

struct BugReportView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject private var vm = BugReportVM()
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("What's wrong?")
            
            VStack(spacing: 16) {
                TextField("Problem", text: $vm.problem)
                    .autocorrectionDisabled()
                    .lineLimit(1)
                    .padding(.horizontal)
                    .padding(.vertical, 12)
                    .overlay {
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(lineWidth: 1)
                            .fill()
                    }
                
                TextField("Description", text: $vm.description, axis: .vertical)
                    .autocorrectionDisabled()
                    .multilineTextAlignment(.leading)
                    .lineLimit(10)
                    .padding(.horizontal)
                    .padding(.vertical, 12)
                    .overlay {
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(lineWidth: 1)
                            .fill()
                    }
                
                Spacer()
                
                Button {
                    vm.reportProblem { dismiss() }
                } label: {
                    Text("Report")
                        .foregroundColor(vm.reportDetailsMissing() ? .secondary : .primary)
                        .frame(height: 52)
                        .frame(maxWidth: .infinity)
                        .background(vm.reportDetailsMissing() ? Color(.quaternaryLabel) : Color("PrimaryAccentColor"))
                        .cornerRadius(12)
                }
                .disabled(vm.reportDetailsMissing())
            }
        }
        .padding()
        .navigationTitle("Report a Problem")
        .navigationBarTitleDisplayMode(.inline)
        .errorAlert(error: $vm.error)
    }
}

struct BugReportView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            BugReportView()
        }
    }
}
