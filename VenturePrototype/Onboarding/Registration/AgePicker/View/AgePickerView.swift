//
//  AgePickerView.swift
//  VenturePrototype
//
//  Created by Philipp Sanktjohanser on 26.12.22.
//
// TODO: Improvement: Already jump to next TextField when 2 numbers have been put in
// TODO: Convert single digit number in day or month field to 0\(number)

import Combine
import SwiftUI

struct AgePickerView: View {
    @StateObject private var viewModel = AgePickerVM()
    @EnvironmentObject private var onboardingVM: OnboardingVM
    
//    @State private var convertedBirthday = Date()
    
    @FocusState var focusedTextField: Focus?
    @State private var birthDay = ""
    @State private var birthMonth = ""
    @State private var birthYear = ""
    @State private var hasSubmitted = false
    
    var body: some View {
        ZStack {
            // Background
            OnboardingBackground()
            
            // Content
            VStack {
                HStack(spacing: 0) {
                    TextField("DD", text: $birthDay)
                        .font(.largeTitle.bold())
                        .keyboardType(.numberPad)
                        .fixedSize()
                        .multilineTextAlignment(.center)
                        .lineLimit(1)
                        .focused($focusedTextField, equals: .day)
                        .onReceive(Just(birthDay)) { newValue in
                            let filtered = newValue.filter { Set("0123456789").contains($0) }
                            if filtered != newValue {
                                self.birthDay = filtered
                            }
                        }
                        .onChange(of: birthDay) { newValue in
                            if newValue.count == 2 {
                                focusedTextField = .month
                            } else if newValue.count > 2 {
                                birthMonth = String(birthDay.suffix(1))
                                birthDay = String(birthDay.prefix(2))
                            }
                        }
                    
                    Text(" ")
                        .font(.largeTitle)
                    
                    TextField("MM", text: $birthMonth)
                        .font(.largeTitle.bold())
                        .keyboardType(.numberPad)
                        .fixedSize()
                        .multilineTextAlignment(.center)
                        .lineLimit(1)
                        .focused($focusedTextField, equals: .month)
                        .onReceive(Just(birthMonth)) { newValue in
                            let filtered = newValue.filter { Set("0123456789").contains($0) }
                            if filtered != newValue {
                                self.birthMonth = filtered
                            }
                        }
                        .onChange(of: birthMonth) { newValue in
                            if newValue.count == 2 {
                                focusedTextField = .year
                            } else if newValue.count > 2 {
                                birthYear = String(birthMonth.suffix(1))
                                birthMonth = String(birthMonth.prefix(2))
                            } else if newValue.isEmpty {
                                focusedTextField = .day
                            }
                        }
                    
                    Text(" ")
                        .font(.largeTitle)

                    TextField("YYYY", text: $birthYear)
                        .font(.largeTitle.bold())
                        .keyboardType(.numberPad)
                        .fixedSize()
                        .multilineTextAlignment(.center)
                        .lineLimit(1)
                        .focused($focusedTextField, equals: .year)
                        .onReceive(Just(birthYear)) { newValue in
                            let filtered = newValue.filter { Set("0123456789").contains($0) }
                            if filtered != newValue {
                                self.birthYear = filtered
                            }
                        }
                        .onChange(of: birthYear) { newValue in
                            if newValue.count > 4 {
                                birthYear = String(birthYear.prefix(4))
                            } else if newValue.isEmpty {
                                focusedTextField = .month
                            }
                        }
                }
                .onChange(of: focusedTextField) { newValue in
                    switch newValue {
                    case .none: return
                    case .day: return
                    case .month:
                        if birthDay.count == 1 {
                            let temp = birthDay
                            birthDay = "0\(temp)"
                        }
                        return
                    case .year:
                        if birthMonth.count == 1 {
                            let temp = birthMonth
                            birthMonth = "0\(temp)"
                        }
                        return
                    }
                }
                
                Spacer()
                
                Button {
                    submit()
                } label: {
                    Text("Continue")
                        .foregroundColor(dateInformationMissing() ? .secondary : .primary)
                        .frame(height: 52)
                        .frame(maxWidth: .infinity)
                        .background(dateInformationMissing() ? Color(.quaternaryLabel) : Color("PrimaryAccentColor"))
                        .cornerRadius(12)
                }
                .disabled(dateInformationMissing())
                
            }
            .padding([.horizontal, .bottom])
        }
        .navigationTitle("When is your birthday?")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden()
        .navigationDestination(isPresented: $hasSubmitted) {
            UsernamePickerView()
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                NavigationLink {
                    AuthenticationView()
                } label: {
                    Text("Sign in")
                        .bold()
                        .foregroundColor(Color("PrimaryAccentColor"))
                }
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                focusedTextField = .day
            }
        }
        .errorAlert(error: $viewModel.error)
    }
    
    func dateInformationMissing() -> Bool {
        return birthDay.count < 2 || birthMonth.count < 2 || birthYear.count < 4
    }
    
    func submit() {
        if !dateInformationMissing() {
            viewModel.convertBirthdayStringToDate(birthDay: birthDay, birthMonth: birthMonth, birthYear: birthYear) { convertedDate in
                onboardingVM.registeringUser.birthday = convertedDate
                hasSubmitted.toggle()
            }
        }
    }
}

struct AgeRegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            AgePickerView()
        }
    }
}


//    func checkFocus() {
//        switch viewModel.focusedTextField {
//            case .none:     break
//            case .day:      focusedTextField = .day
//            case .month:    focusedTextField = .month
//            case .year:     focusedTextField = .year
//        }
//    }

//    NSEvent.addLocalMonitorForEvents(matching: .keyDown) {
//        if self.keyDown(with: $0) {
//            return nil // needed to get rid of purr sound
//        } else {
//            return $0
//        }
//    }
//
//    private func keyDown(with event: NSEvent) -> Bool {
//        if event.charactersIgnoringModifiers == String(UnicodeScalar(NSDeleteCharacter)!) {
//            print("Delete key presses!")
//            return true
//        } else {
//            return false
//        }
//    }
