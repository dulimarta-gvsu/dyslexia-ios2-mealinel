//
//  WordScreen.swift
//  dyslexia
//
//  Created by Elizabeth R. Mealing on 3/17/26.
//
import SwiftUI
import Combine
struct WordScreen: View {
    @ObservedObject var viewModel: AppViewModel
    @State private var letters: [Letter] = []
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Dyslexia Word Game")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.black)
            
            HStack(spacing: 16) {
                NavigationLink("History") {
                    HistoryScreen(viewModel: viewModel)
                }
                .buttonStyle(.bordered)
                
                NavigationLink("Settings") {
                    SettingsScreen(viewModel: viewModel)
                }
                .buttonStyle(.bordered)
            }
            
            Button("New Word") {
                viewModel.startNewGame()
            }
            .buttonStyle(.borderedProminent)
            
            VStack(spacing: 10) {
                Text("Moves: \(viewModel.moveCount)")
                    .font(.headline)
                
                Text("Total Score: \(viewModel.totalScore)")
                    .font(.headline)
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(.white.opacity(0.8))
            .cornerRadius(12)
            .shadow(radius: 3)
            
            Spacer()
            
            LetterGroup(
                letters: $letters,
                letterColor: viewModel.letterBackgroundColor
            ) { arr in
                viewModel.rearrange(to: arr)
            }
            
            Spacer()
            
            if viewModel.issolved {
                Text(viewModel.solvedMessage)
                    .font(.title3)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(.green.opacity(0.25))
                    .cornerRadius(12)
                    .shadow(radius: 3)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
        .background(
            LinearGradient(
                colors: [.yellow.opacity(0.7), .orange.opacity(0.5)],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
        )
        .onReceive(viewModel.$letters) { newValue in
            letters = newValue
        }
        .navigationTitle("Game")
    }
}

