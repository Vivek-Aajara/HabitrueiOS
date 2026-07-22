import CoreData

@MainActor
final class HabitRepository {
    private let context: NSManagedObjectContext

    init(context: NSManagedObjectContext? = nil) {
        self.context = context ?? PersistenceController.shared.container.viewContext
    }

    func fetchAll() -> [Habit] {
        let request: NSFetchRequest<HabitEntity> = HabitEntity.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \HabitEntity.createdAt, ascending: true)]
        return (try? context.fetch(request))?.map { $0.toHabit() } ?? []
    }

    func save(_ habit: Habit) {
        let entity = existing(id: habit.id) ?? HabitEntity(context: context)
        entity.update(from: habit)
        saveContext()
    }

    func delete(_ habit: Habit) {
        guard let entity = existing(id: habit.id) else { return }
        context.delete(entity)
        saveContext()
    }

    private func existing(id: UUID) -> HabitEntity? {
        let request: NSFetchRequest<HabitEntity> = HabitEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", id as CVarArg)
        request.fetchLimit = 1
        return try? context.fetch(request).first
    }

    private func saveContext() {
        guard context.hasChanges else { return }
        try? context.save()
    }
}
