//
//  CoreDataHelper.swift
//  ezQuiz
//
//  Created by Ruslan Sadritdinov on 29.04.2023.
//

import CoreData

class CoreDataHelper {

    private let persistentContainer: NSPersistentContainer

    init() {
        persistentContainer = NSPersistentContainer(name: "QuizResults")
        persistentContainer.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Failed to load persistent stores: \(error)")
            }
        }
    }

    // MARK: - Data Writing

    func saveRecord(date: Date, difficulty: Difficulties, gameType: GameType, result: Int) {
        let context = persistentContainer.viewContext

        let record = QuizResult(context: context)
        record.date = date
        record.difficulty = difficulty.rawValue
        record.gameType = gameType.rawValue
        record.result = Int16(result)


        do {
            try context.save()
        } catch {
            fatalError("Failed to save context: \(error)")
        }
    }

    // MARK: - Data Reading

    func getRecords(for difficulty: Difficulties, and gameType: GameType) -> [QuizResult] {
        let context = persistentContainer.viewContext

        let request: NSFetchRequest<QuizResult> = QuizResult.fetchRequest()
        request.predicate = NSPredicate(format: "difficulty == %@ AND gameType == %@", difficulty.rawValue, gameType.rawValue)
        request.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]

        do {
            let records = try context.fetch(request)
            return records
        } catch {
            fatalError("Failed to fetch records: \(error)")
        }
    }

    // MARK: - Data Deletion
    func deleteRecord(difficulty: Difficulties, gameType: GameType) {

        let context = persistentContainer.viewContext

        let request: NSFetchRequest<QuizResult> = QuizResult.fetchRequest()
        request.predicate = NSPredicate(format: "difficulty == %@ AND gameType == %@", difficulty.rawValue, gameType.rawValue)

        do {
            let records = try context.fetch(request)
            for record in records {
                context.delete(record)
            }
            do {
                try context.save()
            } catch let saveError {
                print("Failed to save context: \(saveError)")
            }
        } catch let fetchError {
            print("Failed to fetch records: \(fetchError)")
        }
    }

}
