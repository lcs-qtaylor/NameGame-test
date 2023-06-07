//
//  NameGame_testApp.swift
//  NameGame test
//
//  Created by Quin Taylor on 2023-06-07.
//

import SwiftUI
import Blackbird

@main
struct QuestionApp: App {
    let questionDatabase: QuestionDatabase
    let questionStore: QuestionStore

    init() {
        // Setup the SQLite database
        let databasePath = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).first!.appendingPathComponent("db.sqlite").path
        let database = try! Blackbird.Database(path: databasePath)
        self.questionDatabase = SQLiteQuestionDatabase(database: database)

        // Initialize the question store
        self.questionStore = QuestionStore(questionDatabase: questionDatabase)
    }

    var body: some Scene {
        WindowGroup{
            ContentView(questionStore: questionStore)
        }
    }
}
