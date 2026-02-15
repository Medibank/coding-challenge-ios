//
//  medibankNewsArticlesApp.swift
//  medibankNewsArticles
//
//  Created by Eunice Chan on 15/2/2026.
//

import SwiftUI
import CoreData

@main
struct medibankNewsArticlesApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
