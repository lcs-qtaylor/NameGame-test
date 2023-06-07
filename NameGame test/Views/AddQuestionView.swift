//import SwiftUI
//
//struct AddQuestionView: View {
//    @Environment(\.presentationMode) private var presentationMode
//    @State private var imageName: String = ""
//    @State private var correctAnswer: String = ""
//
//    var addQuestionAction: ((_ question: Question) -> Void)
//
//    var body: some View {
//        NavigationView {
//            VStack {
//                Form {
//                    Section(header: Text("Question Details")) {
//                        TextField("Image Name", text: $imageName)
//                        TextField("Correct Answer", text: $correctAnswer)
//                    }
//                }
//
//                Button(action: addQuestion) {
//                    Text("Add Question")
//                        .padding()
//                        .frame(maxWidth: .infinity)
//                        .background(Color.blue)
//                        .foregroundColor(.white)
//                        .cornerRadius(8)
//                }
//                .padding()
//            }
//            .navigationTitle("Add Question")
//            .toolbar {
//                ToolbarItem(placement: .navigationBarLeading) {
//                    Button(action: dismiss) {
//                        Text("Cancel")
//                    }
//                }
//            }
//        }
//    }
//
//    private func addQuestion() {
//        let question = Question(imageName: imageName, correctAnswer: correctAnswer)
//        addQuestionAction(question)
//        dismiss()
//    }
//
//    private func dismiss() {
//        presentationMode.wrappedValue.dismiss()
//    }
//}
//struct AddQuestionView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddQuestionView()
//    }
//}
import SwiftUI
import Blackbird

struct AddQuestionView: View {
    @EnvironmentObject var questionStore: QuestionStore
    @Environment(\.presentationMode) private var presentationMode
    @State private var imageName: String = ""
    @State private var correctAnswer: String = ""

    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section(header: Text("Question Details")) {
                        TextField("Image Name", text: $imageName)
                        TextField("Correct Answer", text: $correctAnswer)
                    }
                }
                
                Button(action: addQuestion) {
                    Text("Add Question")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .padding()
            }
            .navigationTitle("Add Question")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: dismiss) {
                        Text("Cancel")
                    }
                }
            }
        }
    }

    private func addQuestion() {
        let question = Question(imageName: imageName, correctAnswer: correctAnswer)
        questionStore.addQuestion(question)
        dismiss()
    }

    private func dismiss() {
        presentationMode.wrappedValue.dismiss()
    }
}
struct AddQuestionView_Previews: PreviewProvider {
    static var previews: some View {
        AddQuestionView()
    }
}
