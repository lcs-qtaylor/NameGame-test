//
//  AddPersonView.swift
//  NameGame test
//
//  Created by Quin Taylor on 2023-06-07.
//
import SwiftUI

struct AddPersonView: View {
    @State private var imageName = ""
    @State private var answer = ""
    
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var questionHelper: QuestionTableHelper
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Image")) {
                    TextField("Image Name", text: $imageName)
                }
                
                Section(header: Text("Answer")) {
                    TextField("Correct Answer", text: $answer)
                }
                
                Section {
                    Button(action: addQuestion) {
                        Text("Add Question")
                    }
                    .disabled(imageName.isEmpty || answer.isEmpty)
                }
            }
            .navigationTitle("Add Person")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("Cancel")
                    }
                }
            }
        }
    }
    
    func addQuestion() {
        let question = Question(imageName: imageName, correctAnswer: answer)
        questionHelper.insertQuestion(question)
        
        presentationMode.wrappedValue.dismiss()
    }
}

struct AddPersonView_Previews: PreviewProvider {
    static var previews: some View {
        AddPersonView(questionHelper: QuestionTableHelper())
    }
}
