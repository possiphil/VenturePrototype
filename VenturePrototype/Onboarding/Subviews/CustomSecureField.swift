//
//  CustomSecureField.swift
//  VenturePrototype
//
//  Created by Philipp Sanktjohanser on 28.12.22.
//
// TODO: Make text somehow look fine and take the space of password points

import Combine
import SwiftUI

struct CustomSecureField: View {
    let placeholder: String
    @State private var showText: Bool = false
    @Binding var text: String
    var onCommit: (()->Void)?
    
//    @State private var animationValue = 1.0
        
        var body: some View {
            HStack {
                ZStack {
                    if showText {
                        HStack {
                            Text(text)
//                                .bold()
                                .foregroundColor(.primary)
                                .lineLimit(1)
                                .kerning(2)
                            
//                            RoundedRectangle(cornerRadius: 2)
//                                .fill(Color(.systemBlue))
//                                .frame(width: 2, height: 10)
//                                .opacity(animationValue)
                            
                            Spacer()
                        }
//                        .allowsHitTesting(false)
                    }
                    
                    SecureField(placeholder, text: $text, onCommit: {
                        onCommit?()
                    })
//                    .autocorrectionDisabled()
//                    .opacity(showText ? 0 : 1)
                    .foregroundColor(showText ? .clear : .primary)
                    .onReceive(Just(text)) { newValue in
                        let filtered = newValue.filter { !Set(" ").contains($0) }
                        if filtered != newValue {
                            self.text = filtered
                        }
                    }
                }
                
                Button(action: {
                    showText.toggle()
                }, label: {
                    Image(systemName: showText ? "eye.slash.fill" : "eye.fill")
                })
                .accentColor(.secondary)
            }
            .frame(height: 52)
            .padding(.horizontal)
            .background(Color("PrimaryAccentColor").opacity(0.1))
            .cornerRadius(12)
            .overlay {
                RoundedRectangle(cornerRadius: 12)
                    .stroke(lineWidth: 2)
                    .fill(Color("PrimaryAccentColor"))
            }
        }
}

struct CustomSecureField_Previews: PreviewProvider {
    static var previews: some View {
        CustomSecureField(placeholder: "Password", text: .constant(""))
    }
}

struct CSField: View {
//    SecureField("Password", text: $password)
    //                            .autocorrectionDisabled()
    //                            .frame(height: 52)
    //                            .padding(.horizontal)
    //                            .background(Color("PrimaryAccentColor").opacity(0.1))
    //                            .cornerRadius(12)
    //                            .overlay {
    //                                RoundedRectangle(cornerRadius: 12)
    //                                    .stroke(lineWidth: 2)
    //                                    .fill(Color("PrimaryAccentColor"))
    //                            }
    
    @Binding var text: String
    @State private var showPassword = false
    @FocusState var inFocus: Field?
    
    enum Field {
        case plain
        case secure
    }
    
    @ViewBuilder
        func secureField() -> some View {
            if self.showPassword {
                TextField("Password", text: $text)
                    .textInputAutocapitalization(.none)
                    .autocorrectionDisabled()
                    .frame(height: 52)
                    .padding(.horizontal)
                    .background(Color("PrimaryAccentColor").opacity(0.1))
                    .cornerRadius(12)
                    .overlay {
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(lineWidth: 2)
                            .fill(Color("PrimaryAccentColor"))
                    }
                    .overlay(
                        Image(systemName: "eye.slash.fill")
                            .font(.system(size: 15, weight: .medium))
                            .foregroundColor(Color.secondary)
                            .padding()
                            .onTapGesture {
                                showPassword.toggle()
                            }
                        , alignment: .trailing
                    )
            } else {
                SecureField("Password", text: $text)
                    .textInputAutocapitalization(.none)
                    .autocorrectionDisabled()
                    .frame(height: 52)
                    .padding(.horizontal)
                    .background(Color("PrimaryAccentColor").opacity(0.1))
                    .cornerRadius(12)
                    .overlay {
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(lineWidth: 2)
                            .fill(Color("PrimaryAccentColor"))
                    }
                    .overlay(
                        Image(systemName: "eye.fill")
                            .font(.system(size: 15, weight: .medium))
                            .foregroundColor(Color.secondary)
                            .padding()
                            .onTapGesture {
                                showPassword.toggle()
                            }
                        , alignment: .trailing
                    )
            }
        }
    
    var body: some View {
        
        
        Group {
            if showPassword {
                TextField("Password", text: $text)
                    .focused($inFocus, equals: .plain)
            } else {
                SecureField("Password", text: $text)
                    .focused($inFocus, equals: .secure)
            }
        }
        .frame(height: 52)
        .padding(.horizontal)
        .background(Color("PrimaryAccentColor").opacity(0.1))
        .cornerRadius(12)
        .overlay {
            RoundedRectangle(cornerRadius: 12)
                .stroke(lineWidth: 2)
                .fill(Color("PrimaryAccentColor"))
        }
        .overlay(
            Image(systemName: showPassword ? "eye.slash.fill" : "eye.fill")
                .font(.system(size: 15, weight: .medium))
                .foregroundColor(Color.secondary)
                .padding()
                .onTapGesture {
                    showPassword.toggle()
                    inFocus = showPassword ? .plain : .secure
                }
            , alignment: .trailing
        )
    }
}
