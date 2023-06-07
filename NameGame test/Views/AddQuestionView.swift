


import SwiftUI
import UIKit

struct AddQuestionView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var image: UIImage?
    @Binding var answer: String
    var onSave: () -> Void
    
    var body: some View {
        VStack {
            ZStack {
                Rectangle()
                    .stroke(Color.black, lineWidth: 1)
                    .aspectRatio(1, contentMode: .fit)
                    .background(Color.gray)
                
                if let image = image {
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding()
                } else {
                    VStack {
                        
                        Image(systemName: "photo")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 50, height: 50)
                        
                        Text("No Image Selected")
                            .foregroundColor(.black)
                            .font(.headline)
                    }
                     
                }
            }
            
            Button(action: {
                showImagePicker()
            }) {

                Image(systemName: "camera.on.rectangle.fill")
                Text("Add Image")
                foregroundColor(.white)
            }
            .padding()
            
            TextField("Enter the answer", text: $answer)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            HStack {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
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
        picker.delegate = context.coordinator // Set the delegate to handle image selection
        
        UIApplication.shared.windows.first?.rootViewController?.present(picker, animated: true, completion: nil)
#endif
    }
    
    // Coordinator for handling image picker delegate methods
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: AddQuestionView
        
        init(_ parent: AddQuestionView) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            guard let selectedImage = info[.originalImage] as? UIImage else {
                return
            }
            
            parent.image = selectedImage
            picker.dismiss(animated: true, completion: nil)
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            picker.dismiss(animated: true, completion: nil)
        }
    }
    
    // Create and use the coordinator
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
}

struct AddQuestionView_Previews: PreviewProvider {
    static var previews: some View {
        AddQuestionView(image: .constant(nil), answer: .constant(""), onSave: {})
    }
}



