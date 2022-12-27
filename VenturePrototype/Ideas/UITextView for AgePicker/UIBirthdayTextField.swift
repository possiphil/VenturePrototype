//
//  UIBirthdayTextField.swift
//  VenturePrototype
//
//  Created by Philipp Sanktjohanser on 27.12.22.
//

import SwiftUI

struct UIBirthdayTextField: UIViewRepresentable {
    private let tmpView = UIWrappableTextField()

    //var exposed to SwiftUI object init
    var tag: Int = 0
    var placeholder: String?
    var text: String?
    var changeHandler: ((String)->Void)?
    var onCommitHandler: (()->Void)?
    var deleteHandler: (()->Void)?

    func makeUIView(context: UIViewRepresentableContext<UIBirthdayTextField>) -> UIWrappableTextField {
        tmpView.tag = tag
        tmpView.delegate = tmpView
        tmpView.placeholder = placeholder
        tmpView.text = text
        tmpView.onCommitHandler = onCommitHandler
        tmpView.textFieldChangedHandler = changeHandler
        tmpView.deleteHandler = deleteHandler
        return tmpView
    }

    func updateUIView(_ uiView: UIWrappableTextField, context: UIViewRepresentableContext<UIBirthdayTextField>) {
        uiView.setContentHuggingPriority(.defaultHigh, for: .vertical)
        uiView.setContentHuggingPriority(.defaultLow, for: .horizontal)
    }
}

