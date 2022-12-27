//
//  DayPickerTextField.swift
//  VenturePrototype
//
//  Created by Philipp Sanktjohanser on 27.12.22.
//

import SwiftUI

struct DayPickerTextField: View {
    @ObservedObject var viewModel: AgePickerVM
    
    @FocusState var focusedTextField: Focus?
    
    var body: some View {
        TextField("DD", text: $viewModel.birthDay)
            .font(.largeTitle.bold())
            .keyboardType(.numberPad)
            .fixedSize()
            .multilineTextAlignment(.center)
            .lineLimit(1)
            .focused($focusedTextField, equals: Focus.day)
            .onChange(of: viewModel.birthDay) { newValue in
                if newValue.count > 2 {
                    viewModel.birthMonth = String(viewModel.birthDay.suffix(1))
                    viewModel.birthDay = String(viewModel.birthDay.prefix(2))
                    viewModel.focusedTextField = .month
                }
            }
    }
}

struct DayPickerTextField_Previews: PreviewProvider {
    static var previews: some View {
        DayPickerTextField(viewModel: AgePickerVM())
    }
}
