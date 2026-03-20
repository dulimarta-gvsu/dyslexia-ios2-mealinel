//
//  WordRecord.swift
//  dyslexia
//
//  Created by Elizabeth R. Mealing on 3/17/26.
//
import Foundation
struct WordRecord: Identifiable {
    let id = UUID()
    let word: String
    let points: Int
    let moves: Int
    let seconds: Int
}

