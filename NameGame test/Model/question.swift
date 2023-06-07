//
//  Question.swift
//  NameGame test
//
//  Created by Quin Taylor on 2023-06-07.
//

import Blackbird

struct Question: Codable, Identifiable {
    let id: UUID
    let imageName: String
    let correctAnswer: String
}
