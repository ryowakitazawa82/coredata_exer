//
//  MyCoreDataApp.swift
//  MyCoreData
//
//  Created by 北沢　亮和 on 2022/07/31.
//

import SwiftUI

@main
struct MyCoreDataApp: App {
    let persistenceController = PersistenceController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
