import SwiftUI
import Blackbird
import BlackbirdSQLite

struct ContentView: View {
    @StateObject private var database = BlackbirdSQLite.default()
    @State private var currentQuestionIndex = 0
    @State private var userAnswer = ""
    @State private var isAnswerCorrect = false
    @State private var showAddQuestionMenu = false
    @State private var newImage: UIImage? = nil
    @State private var newAnswer = ""
    @State private var questions: [Question] = []

    var body: some View {
        NavigationView {
            // ... rest of your view code
        }
        .onAppear {
            loadQuestions()
        }
    }

    func loadQuestions() {
        do {
            let storedQuestions: [Question] = try database.readAll()
            questions = storedQuestions
        } catch {
            print("Failed to load questions: \(error)")
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
            let question = Question(id: UUID(), imageName: imageName, correctAnswer: newAnswer)
            try database.create(question)
            questions.append(question)
        } catch {
            print("Failed to save image: \(error)")
        }
    }
    
    func getDocumentsDirectory() -> URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
}

struct AddQuestionView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var image: UIImage?
    @Binding var answer: String
    var onSave: () -> Void

    var body: some View {
        VStack {
            Button(action: {
                showImagePicker()
            }) {
                Text("Add Image")
            }
            .padding()

            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding()
            }

            TextField("Enter the answer", text: $answer)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            HStack {
                Button(action: {
                    cancel()
                }) {
                    Text("Cancel")
                }
                .padding()

                Button(action: {
                    onSave()
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Save Question")
                }
                .padding()
            }

            Spacer()
        }
    }

    func showImagePicker() {
#if targetEnvironment(simulator)
        print("Cannot access camera on simulator.")
#else
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = context.coordinator
        presentationMode.wrappedValue.present(picker, animated: true, completion: nil)
#endif
    }
    func cancel() {
            presentationMode.wrappedValue.dismiss()
        }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
