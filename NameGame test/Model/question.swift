//
//  Question.swift
//  NameGame test
//
//  Created by Quin Taylor on 2023-06-07.
//
//import Blackbird
//import Foundation
//
//struct Question: BlackbirdModel {
//    @BlackbirdColumn var id = Int
//    @BlackbirdColumn var imageName: String
//    @BlackbirdColumn var correctAnswer: String
//}

struct Question: Identifiable {
    let id: Int
    let imageName: String
    let correctAnswer: String
}
