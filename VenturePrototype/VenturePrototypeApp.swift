//
//  VenturePrototypeApp.swift
//  VenturePrototype
//
//  Created by Philipp Sanktjohanser on 26.12.22.
//

import Firebase
import SwiftUI

@main
struct VenturePrototypeApp: App {
    @StateObject var onboardingVM = OnboardingVM()
    @StateObject private var dataController = DataController()
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            LaunchScreenView()
                .environmentObject(onboardingVM)
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
