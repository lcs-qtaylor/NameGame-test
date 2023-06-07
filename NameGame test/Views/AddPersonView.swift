//import SwiftUI
//
//struct AddPersonView: View {
//
//    @State private var imageName = ""
//    @State private var correctAnswer = ""
//    
//    var body: some View {
//        NavigationView {
//            VStack {
//                TextField("Image Name", text: $imageName)
//                    .textFieldStyle(RoundedBorderTextFieldStyle())
//                    .padding()
//                
//                TextField("Correct Answer", text: $correctAnswer)
//                    .textFieldStyle(RoundedBorderTextFieldStyle())
//                    .padding()
//                
//                Spacer()
//                
//                Button("Add Question") {
//                    addQuestion()
//                    presentationMode.wrappedValue.dismiss()
//                }
//                .padding()
//            }
//            .navigationBarTitle("Add Person")
//        }
//    }
//    
//    func addQuestion() {
//        let newQuestion = Question(imageName: imageName, correctAnswer: correctAnswer)
//        questions.append(newQuestion)
//        imageName = ""
//        correctAnswer = ""
//    }
//}
//struct AddPersonView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddPersonView()
//    }
//}
