//
//  AgePickerView.swift
//  VenturePrototype
//
//  Created by Philipp Sanktjohanser on 26.12.22.
//
// TODO: Improvement: Already jump to next TextField when 2 numbers have been put in
#warning("BUG: When TextField is empty and user presses delete button, nothing happens. Should: Go to previous Textfield.")


import SwiftUI

struct AgePickerView: View {
    @StateObject private var viewModel = AgePickerVM()
    
    @FocusState var focusedTextField: Focus?
    @State private var birthDay = ""
    @State private var birthMonth = ""
    @State private var birthYear = ""
    
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
                        .onChange(of: birthYear) { newValue in
                            if newValue.count > 4 {
                                birthYear = String(birthYear.prefix(4))
                            } else if newValue.isEmpty {
                                focusedTextField = .month
                            }
                        }
                }
                
                Spacer()
                
                OnboardingButton(destination: UsernamePickerView(), title: "Continue", isDisabled: dateInformationMissing())
            }
            .padding(.horizontal)
            .padding(.bottom)
        }
        .navigationTitle("When is your birthday?")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden()
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
    }
    func dateInformationMissing() -> Bool {
        return birthDay.count < 2 || birthMonth.count < 2 || birthYear.count < 4
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
