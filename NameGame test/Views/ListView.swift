import SwiftUI

struct ListView: View {
    @State private var questions: [ListItem] = [
        ListItem(imageName: "image1", correctAnswer: "John"),
        ListItem(imageName: "image2", correctAnswer: "Emily"),
        ListItem(imageName: "image3", correctAnswer: "Michael")
    ]
    
    var body: some View {
        List(questions) { (question: ListItem) in
            HStack {
                Image(question.imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 80, height: 80)
                    .padding(8)
                    .background(Color.black)
                    .cornerRadius(8)
                
                Text(question.correctAnswer)
                    .padding(8)
                    .background(Color.black)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
        }
    }
}

struct ListItem: Identifiable {
    let id = UUID()
    let imageName: String
    let correctAnswer: String
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}
