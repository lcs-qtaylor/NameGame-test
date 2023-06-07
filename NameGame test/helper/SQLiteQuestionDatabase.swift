//
//  SQLiteQuestionDatabase.swift
//  NameGame test
//
//  Created by Quin Taylor on 2023-06-07.
//
//
//import Blackbird
//import Foundation
//
//// MARK: - SQLite Question Database
//
//struct SQLiteQuestionDatabase: QuestionDatabase {
//    private let database: Blackbird.Database
//
//    init(database: Blackbird.Database) {
//        self.database = database
//    }
//
//    func loadQuestions() -> [Question] {
//        do {
//            let statement = "SELECT * FROM Questions"
//            let results = try database.execute(statement)
//            var questions: [Question] = []
//            for row in results {
//                let id = row["id"] as! Int
//                let imageName = row["imageName"] as! String
//                let correctAnswer = row["correctAnswer"] as! String
//                let question = Question(id: id, imageName: imageName, correctAnswer: correctAnswer)
//                questions.append(question)
//            }
//            return questions
//        } catch {
//            print("Failed to load questions: \(error)")
//            return []
//        }
//    }
//
//    func addQuestion(_ question: Question) {
//        do {
//            let statement = "INSERT INTO Questions (imageName, correctAnswer) VALUES ('\(question.imageName)', '\(question.correctAnswer)')"
//            try database.execute(statement)
//        } catch {
//            print("Failed to add question: \(error)")
//        }
//    }
//
//    func removeQuestion(_ question: Question) {
//        do {
//            let statement = "DELETE FROM Questions WHERE id = \(question.id)"
//            try database.execute(statement)
//        } catch {
//            print("Failed to remove question: \(error)")
//        }
//    }
//
//    func updateQuestion(_ question: Question) {
//        do {
//            let statement = "UPDATE Questions SET imageName = '\(question.imageName)', correctAnswer = '\(question.correctAnswer)' WHERE id = \(question.id)"
//            try database.execute(statement)
//        } catch {
//            print("Failed to update question: \(error)")
//        }
//    }
//}
