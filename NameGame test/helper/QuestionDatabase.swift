import Foundation

protocol QuestionDatabase {
    func loadQuestions() -> [Question]
    func addQuestion(_ question: Question)
    func removeQuestion(_ question: Question)
    func updateQuestion(_ question: Question)
}

// Example implementation using UserDefaults
class UserDefaultsQuestionDatabase: QuestionDatabase {
    private let userDefaults: UserDefaults
    private let questionsKey = "questionsKey"

    init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
    }

    func loadQuestions() -> [Question] {
        if let encodedQuestions = userDefaults.data(forKey: questionsKey),
           let questions = try? JSONDecoder().decode([Question].self, from: encodedQuestions) {
            return questions
        } else {
            return []
        }
    }

    func addQuestion(_ question: Question) {
        var questions = loadQuestions()
        questions.append(question)

        if let encodedQuestions = try? JSONEncoder().encode(questions) {
            userDefaults.set(encodedQuestions, forKey: questionsKey)
        }
    }

    func removeQuestion(_ question: Question) {
        var questions = loadQuestions()
        if let index = questions.firstIndex(of: question) {
            questions.remove(at: index)
            if let encodedQuestions = try? JSONEncoder().encode(questions) {
                userDefaults.set(encodedQuestions, forKey: questionsKey)
            }
        }
    }

    func updateQuestion(_ question: Question) {
        var questions = loadQuestions()
        if let index = questions.firstIndex(of: question) {
            questions[index] = question
            if let encodedQuestions = try? JSONEncoder().encode(questions) {
                userDefaults.set(encodedQuestions, forKey: questionsKey)
            }
        }
    }
}

// Example implementation using SQLite
