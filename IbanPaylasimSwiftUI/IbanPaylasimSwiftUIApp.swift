//
//  IbanPaylasimSwiftUIApp.swift
//  IbanPaylasimSwiftUI
//
//  Created by Çağatay Çürük on 20.11.2022.
//

import SwiftUI

@main
struct IbanPaylasimSwiftUIApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
