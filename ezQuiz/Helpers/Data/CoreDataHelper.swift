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
        persistentContainer = NSPersistentContainer(name: "NameOfYourDataModel")
        persistentContainer.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Failed to load persistent stores: \(error)")
            }
        }
    }

    // MARK: - Запись данных

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

    // MARK: - Получение данных

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
}
