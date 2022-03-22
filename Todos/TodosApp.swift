//
//  TodosApp.swift
//  Todos
//
//  Created by wizz on 12/8/21.
//

import SwiftUI

@main
struct TodosApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
