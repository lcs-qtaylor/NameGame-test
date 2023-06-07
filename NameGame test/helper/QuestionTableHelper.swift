//
//  QuestionTableHelper.swift
//  NameGame test
//
//  Created by Quin Taylor on 2023-06-07.
//

import SQLite3

struct QuestionTableHelper {
    let db: Connection
    let table = Table("questions")
    let id = Expression<Int64>("id")
    let imageName = Expression<String>("imageName")
    let correctAnswer = Expression<String>("correctAnswer")
    
    init() {
        let path = NSSearchPathForDirectoriesInDomains(
            .documentDirectory, .userDomainMask, true
        ).first!
        
        do {
            db = try Connection("\(path)/questions.sqlite")
            createTable()
        } catch {
            fatalError("Error connecting to database: \(error)")
        }
    }
    
    func createTable() {
        do {
            try db.run(table.create { table in
                table.column(id, primaryKey: .autoincrement)
                table.column(imageName)
                table.column(correctAnswer)
            })
        } catch {
            fatalError("Error creating table: \(error)")
        }
    }
    
    func insertQuestion(_ question: Question) {
        let insert = table.insert(
            imageName <- question.imageName,
            correctAnswer <- question.correctAnswer
        )
        
        do {
            try db.run(insert)
        } catch {
            fatalError("Error inserting question: \(error)")
        }
    }
    
    func fetchAllQuestions() -> [Question] {
        var questions: [Question] = []
        
        do {
            let rows = try db.prepare(table)
            for row in rows {
                let question = Question(
                    imageName: row[imageName],
                    correctAnswer: row[correctAnswer]
                )
                questions.append(question)
            }
        } catch {
            fatalError("Error fetching questions: \(error)")
        }
        
        return questions
    }
}

