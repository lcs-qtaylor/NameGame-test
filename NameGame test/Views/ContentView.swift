

import SwiftUI

struct ContentView: View {
    @State private var currentQuestionIndex = 0
    @State private var userAnswer = ""
    @State private var isAnswerCorrect = false
    @State private var showAddQuestionMenu = false
    @State private var newImage: UIImage? = nil
    @State private var newAnswer = ""
    @State private var questions = [
        Question(imageName: "image1", correctAnswer: "John"),
        Question(imageName: "image2", correctAnswer: "Emily"),
        Question(imageName: "image3", correctAnswer: "Michael")
    ]
    
    var body: some View {
        NavigationView {
            VStack {
                Image(questions[currentQuestionIndex].imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding()
                
                TextField("Enter the name", text: $userAnswer)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                Button(action: {
                    checkAnswer()
                }) {
                    Image(systemName:"checkmark.circle")
                }
                .padding()
                
                Button(action: {
                    goToNextQuestion()
                }) {
                    Text("Skip to Next Question")
                }
                .padding()
                
                Text(isAnswerCorrect ? "Correct!" : "Incorrect!")
                    .foregroundColor(isAnswerCorrect ? .green : .red)
                    .font(.headline)
                    .padding()
                
                Spacer()
            }
            .navigationTitle("Question")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showAddQuestionMenu = true
                    }) {
                        Label("Add Question", systemImage: "person.fill.badge.plus")
                    }
                }
            }
            .sheet(isPresented: $showAddQuestionMenu, onDismiss: {
                newImage = nil
                newAnswer = ""
            }) {
                AddQuestionView(image: $newImage, answer: $newAnswer) {
                    addQuestion()
                }
            }
        }
    }
    
    func checkAnswer() {
        if userAnswer.lowercased() == questions[currentQuestionIndex].correctAnswer.lowercased() {
            isAnswerCorrect = true
        } else {
            isAnswerCorrect = false
        }
    }
    
    func goToNextQuestion() {
        userAnswer = ""
        isAnswerCorrect = false
        
        if currentQuestionIndex < questions.count - 1 {
            currentQuestionIndex += 1
        } else {
            currentQuestionIndex = 0
        }
    }
    
    func addQuestion() {
        guard let newImage = newImage, let imageData = newImage.jpegData(compressionQuality: 0.8) else {
            return
        }
        
        let imageName = UUID().uuidString
        let imagePath = getDocumentsDirectory().appendingPathComponent(imageName)
        
        do {
            try imageData.write(to: imagePath)
            let question = Question(imageName: imageName, correctAnswer: newAnswer)
            questions.append(question)
        } catch {
            print("Failed to save image: \(error)")
        }
    }
    
    func getDocumentsDirectory() -> URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}





