//
//  AppViewModel.swift
//  dyslexia
//
import Foundation
import Combine
import SwiftUI
class AppViewModel: ObservableObject {
    @Published var letters: [Letter] = []
    @Published var moveCount: Int = 0
    @Published var elapsedTime: Int = 0
    @Published var totalScore: Int = 0
    @Published var solvedMessage: String = ""
    @Published var issolved: Bool = false
    @Published var gameHistory: [WordRecord] = []
    
    @Published var minWordLength: Double = 3
    @Published var maxWordLength: Double = 12
    @Published var redValue: Double = 0.0
    @Published var greenValue: Double = 1.0
    @Published var blueValue: Double = 1.0
    
    var letterBackgroundColor: Color {
        Color(red: redValue, green: greenValue, blue: blueValue)
    }
    
    private let vocabulary: [String] = [
        "cat", "dog", "mouse", "horse", "bird", "wolf", "fox", "lion",
        "zebra", "koala", "lizard", "giraffe", "hippo", "penguin",
        "eagle", "rat", "bat", "swan", "squirrel", "bear", "deer",
        "possum", "skunk", "whale", "shark", "jellyfish", "seahorse",
        "kangaroo", "flamingo", "parrot", "elephant", "monkey"
    ]
    
    private let letterScores: [Character: Int] = [
        "A": 1, "B": 3, "C": 3, "D": 2, "E": 1, "F": 2, "G": 2,
        "H": 2, "I": 1, "J": 3, "K": 2, "L": 2, "M": 2, "N": 2,
        "O": 1, "P": 2, "Q": 3, "R": 2, "S": 2, "T": 3, "U": 1,
        "V": 4, "W": 3, "X": 4, "Y": 1, "Z": 4
    ]
    
    private var secretWord: String = ""
    private var startTime: Date = Date()
    
    init() {
        self.startNewGame()
    }
    
    func startNewGame() {
        if !secretWord.isEmpty && !issolved && !letters.isEmpty {
            addHistoryRecord(points: 0)
        }
        
        let filteredWords = vocabulary.filter {
            $0.count >= Int(minWordLength) && $0.count <= Int(maxWordLength)
        }
        
        let sourceWords = filteredWords.isEmpty ? vocabulary : filteredWords
        secretWord = sourceWords.randomElement()!.uppercased()
        
        moveCount = 0
        elapsedTime = 0
        solvedMessage = ""
        issolved = false
        startTime = Date()
        
        letters.removeAll()
        letters.append(contentsOf:
            secretWord.map { ch in
                Letter(
                    text: String(ch),
                    point: letterScores[ch] ?? 1
                )
            }
            .shuffled()
        )
        
        while letters.prettyPrint() == secretWord {
            letters.shuffle()
        }
    }
    
    func rearrange(to newLetters: [Letter]) {
        if newLetters != letters {
            moveCount += 1
        }
        
        letters = newLetters
        
        let guess = newLetters.prettyPrint()
        if guess == secretWord && !issolved {
            issolved = true
            elapsedTime = Int(Date().timeIntervalSince(startTime))
            
            let wordScore = newLetters.reduce(0) { partialResult, letter in
                partialResult + letter.point
            }
            
            totalScore += wordScore
            solvedMessage = "Congratulations! You used \(moveCount) moves in \(elapsedTime) seconds."
            
            addHistoryRecord(points: wordScore)
        }
    }
    
    private func addHistoryRecord(points: Int) {
        let secondsTaken = Int(Date().timeIntervalSince(startTime))
        let record = WordRecord(
            word: secretWord,
            points: points,
            moves: moveCount,
            seconds: secondsTaken
        )
        gameHistory.append(record)
    }
    
    func sortHistoryByWord() {
        gameHistory.sort { $0.word < $1.word }
    }
    
    func sortHistoryByPoints() {
        gameHistory.sort { $0.points > $1.points }
    }
    
    func sortHistoryByMoves() {
        gameHistory.sort { $0.moves < $1.moves }
    }
    
    func sortHistoryBySeconds() {
        gameHistory.sort { $0.seconds > $1.seconds }
    }
}

