
//import Foundation
//import Blackbird
//class QuestionStore: ObservableObject {
//    @Published var questions: [Question] = []
//    @Published var userAnswer: String = ""
//    @Published var answerResultText: String = ""
//    @Published var isAnswerCorrect: Bool = false
//    private let questionDatabase: QuestionDatabase
//    private var currentIndex: Int = 0
//
//    init(questionDatabase: QuestionDatabase) {
//        self.questionDatabase = questionDatabase
//        loadQuestions()
//    }
//
//    func loadQuestions() {
//        questions = questionDatabase.loadQuestions()
//        currentIndex = 0
//        resetAnswerResult()
//    }
//
//    func addQuestion(_ question: Question) {
//        questionDatabase.addQuestion(question)
//        loadQuestions()
//    }
//
//    func removeQuestion(_ question: Question) {
//        questionDatabase.removeQuestion(question)
//        loadQuestions()
//    }
//
//    func updateQuestion(_ question: Question) {
//        questionDatabase.updateQuestion(question)
//        loadQuestions()
//    }
//
//    func goToNextQuestion() {
//        currentIndex += 1
//        if currentIndex >= questions.count {
//            currentIndex = 0
//        }
//        resetAnswerResult()
//    }
//
//    func checkAnswer() {
//        guard currentIndex < questions.count else {
//            return
//        }
//        let currentQuestion = questions[currentIndex]
//        isAnswerCorrect = currentQuestion.correctAnswer == userAnswer
//        answerResultText = isAnswerCorrect ? "Correct!" : "Incorrect"
//    }
//
//    private func resetAnswerResult() {
//        userAnswer = ""
//        answerResultText = ""
//        isAnswerCorrect = false
//    }
//}
