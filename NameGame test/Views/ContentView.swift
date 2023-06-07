//import SwiftUI
//import UIKit
//
//struct ContentView: View {
//    @State private var currentQuestionIndex = 0
//    @State private var userAnswer = ""
//    @State private var isAnswerCorrect = false
//    @State private var showAddQuestionMenu = false
//    @State private var newImage: UIImage? = nil
//    @State private var newAnswer = ""
//    @State private var questions = [
//        Question(imageName: "image1", correctAnswer: "John"),
//        Question(imageName: "image2", correctAnswer: "Emily"),
//        Question(imageName: "image3", correctAnswer: "Michael")
//    ]
//
//    var body: some View {
//        NavigationView {
//            VStack {
//                Image(questions[currentQuestionIndex].imageName)
//                    .resizable()
//                    .aspectRatio(contentMode: .fit)
//                    .padding()
//
//                TextField("Enter the name", text: $userAnswer)
//                    .textFieldStyle(RoundedBorderTextFieldStyle())
//                    .padding()
//
//                Button(action: {
//                    checkAnswer()
//                }) {
//                    Text("Check Answer")
//                }
//                .padding()
//
//                Button(action: {
//                    goToNextQuestion()
//                }) {
//                    Text("Skip to Next Question")
//                }
//                .padding()
//
//                Text(isAnswerCorrect ? "Correct!" : "Incorrect!")
//                    .foregroundColor(isAnswerCorrect ? .green : .red)
//                    .font(.headline)
//                    .padding()
//
//                Spacer()
//            }
//            .navigationTitle("Question")
//            .toolbar {
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    Button(action: {
//                        showAddQuestionMenu = true
//                    }) {
//                        Label("Add Question", systemImage: "person.fill.badge.plus")
//                    }
//                }
//            }
//            .sheet(isPresented: $showAddQuestionMenu, onDismiss: {
//                newImage = nil
//                newAnswer = ""
//            }) {
//                AddQuestionView(image: $newImage, answer: $newAnswer) {
//                    addQuestion()
//                }
//            }
//        }
//    }
//
//    func checkAnswer() {
//        if userAnswer.lowercased() == questions[currentQuestionIndex].correctAnswer.lowercased() {
//            isAnswerCorrect = true
//        } else {
//            isAnswerCorrect = false
//        }
//    }
//
//    func goToNextQuestion() {
//        userAnswer = ""
//        isAnswerCorrect = false
//
//        if currentQuestionIndex < questions.count - 1 {
//            currentQuestionIndex += 1
//        } else {
//            currentQuestionIndex = 0
//        }
//    }
//
//    func addQuestion() {
//        guard let newImage = newImage, let imageData = newImage.jpegData(compressionQuality: 0.8) else {
//            return
//        }
//
//        let imageName = UUID().uuidString
//        let imagePath = getDocumentsDirectory().appendingPathComponent(imageName)
//
//        do {
//            try imageData.write(to: imagePath)
//            let question = Question(imageName: imageName, correctAnswer: newAnswer)
//            questions.append(question)
//        } catch {
//            print("Failed to save image: \(error)")
//        }
//    }
//
//    func getDocumentsDirectory() -> URL {
//        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
//    }
//}
//
//struct Question {
//    let imageName: String
//    let correctAnswer: String
//}
//
//struct AddQuestionView: View {
//    @Environment(\.presentationMode) var presentationMode
//    @Binding var image: UIImage?
//    @Binding var answer: String
//    var onSave: () -> Void
//
//    var body: some View {
//        VStack {
//            Button(action: {
//                showImagePicker()
//            }) {
//                Text("Add Image")
//            }
//            .padding()
//
//            if let image = image {
//                Image(uiImage: image)
//                    .resizable()
//                    .aspectRatio(contentMode: .fit)
//                    .padding()
//            }
//
//            TextField("Enter the answer", text: $answer)
//                .textFieldStyle(RoundedBorderTextFieldStyle())
//                .padding()
//
//            HStack {
//                Button(action: {
//                    presentationMode.wrappedValue.dismiss()
//                }) {
//                    Text("Cancel")
//                }
//                .padding()
//
//                Button(action: {
//                    onSave()
//                    presentationMode.wrappedValue.dismiss()
//                }) {
//                    Text("Save Question")
//                }
//                .padding()
//            }
//
//            Spacer()
//        }
//    }
//
//    func showImagePicker() {
//        #if targetEnvironment(simulator)
//        print("Cannot access camera on simulator.")
//        #else
//        let picker = UIImagePickerController()
//        picker.sourceType = .photoLibrary
//        // Set the delegate here if you want to handle image selection
//        presentationMode.wrappedValue.present(picker, animated: true, completion: nil)
//        #endif
//    }
//}
//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}

import SwiftUI
import Blackbird 
struct ContentView: View {
    @StateObject var questionDatabase = SQLiteQuestionDatabase()

    @State private var questions: [Question] = []
    @State private var currentQuestionIndex = 0
    @State private var userAnswer = ""
    @State private var answerResultText = ""
    @State private var isAnswerCorrect = false

    var currentQuestion: Question? {
        guard questions.indices.contains(currentQuestionIndex) else {
            return nil
        }
        return questions[currentQuestionIndex]
    }

    var body: some View {
        NavigationView {
            VStack {
                if let currentQuestion = currentQuestion {
                    Image(currentQuestion.imageName)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding()
                }

                TextField("Enter the name", text: $userAnswer)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                Button(action: {
                    checkAnswer()
                }) {
                    Text("Check Answer")
                }
                .padding()

                Button(action: {
                    goToNextQuestion()
                }) {
                    Text("Skip to Next Question")
                }
                .padding()

                Text(answerResultText)
                    .foregroundColor(isAnswerCorrect ? .green : .red)
                    .font(.headline)
                    .padding()

                Spacer()
            }
            .navigationTitle("Question")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        // Show AddQuestionView
                    }) {
                        Label("Add Question", systemImage: "person.fill.badge.plus")
                    }
                }
            }
        }
        .onAppear {
            loadQuestions()
        }
    }

    func loadQuestions() {
        do {
            questions = try questionDatabase.loadQuestions()
        } catch {
            print("Failed to load questions: \(error)")
        }
    }

    func addQuestion(_ question: Question) {
        do {
            try questionDatabase.addQuestion(question)
            questions.append(question)
        } catch {
            print("Failed to add question: \(error)")
        }
    }

    func deleteQuestion(at index: Int) {
        guard questions.indices.contains(index) else {
            return
        }
        let question = questions[index]
        do {
            try questionDatabase.deleteQuestion(question)
            questions.remove(at: index)
        } catch {
            print("Failed to delete question: \(error)")
        }
    }

    func updateQuestion(_ question: Question) {
        guard let index = questions.firstIndex(where: { $0.id == question.id }) else {
            return
        }
        do {
            try questionDatabase.updateQuestion(question)
            questions[index] = question
        } catch {
            print("Failed to update question: \(error)")
        }
    }

    func checkAnswer() {
        guard let currentQuestion = currentQuestion else {
            return
        }
        isAnswerCorrect = currentQuestion.correctAnswer.lowercased() == userAnswer.lowercased()
        answerResultText = isAnswerCorrect ? "Correct!" : "Incorrect!"
    }

    func goToNextQuestion() {
        if currentQuestionIndex < questions.count - 1 {
            currentQuestionIndex += 1
        } else {
            currentQuestionIndex = 0
        }
        userAnswer = ""
        answerResultText = ""
        isAnswerCorrect = false
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
