//
//  ContentView.swift
//  NameGame test
//
//  Created by Quin Taylor on 2023-06-07.
//

import SwiftUI

struct ContentView: View {
    @State private var currentQuestionIndex = 0
    @State private var userAnswer = ""
    @State private var isAnswerCorrect = false
    
    let questionHelper = QuestionTableHelper()
    @State private var questions: [Question] = []
    
    @State private var isPresentingAddPersonView = false // Track presentation state
    
    init() {
        questions = questionHelper.fetchAllQuestions()
    }
    
    var body: some View {
        VStack {
            if let currentQuestion = questions[currentQuestionIndex] {
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
            
            Text(isAnswerCorrect ? "Correct!" : "Incorrect!")
                .foregroundColor(isAnswerCorrect ? .green : .red)
                .font(.headline)
                .padding()
            
            Spacer()
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    isPresentingAddPersonView = true
                }) {
                    Image(systemName: "person.fill.badge.plus")
                }
                .sheet(isPresented: $isPresentingAddPersonView) {
                    AddPersonView(questionHelper: questionHelper)
                }
            }
        }
    }
    
    func checkAnswer() {
        if let currentQuestion = questions[currentQuestionIndex],
           userAnswer.lowercased() == currentQuestion.correctAnswer.lowercased() {
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
}

struct Question {
    let imageName: String
    let correctAnswer: String
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
