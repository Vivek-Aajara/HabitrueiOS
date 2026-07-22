//
//  PersistenceController.swift
//  Habitrue
//
//  Created by Project on 21/07/26.
//
import CoreData
import SwiftUI

struct PersistenceController {
    static let shared = PersistenceController()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "Habitrue")
        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores { _, error in
            if let error {
                fatalError("Core Data store failed to load: \(error)")
            }
        }
        container.viewContext.automaticallyMergesChangesFromParent = true
    }

    static var preview: PersistenceController = {
        let controller = PersistenceController(inMemory: true)
        let context = controller.container.viewContext
        let sample = HabitEntity(context: context)
        sample.update(from: Habit(title: "Morning focus routine", emoji: "⛩️"))
        try? context.save()
        return controller
    }()
}
