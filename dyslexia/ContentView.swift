//
//  ContentView.swift
//  dyslexia
//
import SwiftUI
import Combine
struct ContentView: View {
    //init(viewModel: AppViewModel) {
    //    self._viewModel = ObservedObject(wrappedValue: //viewModel)
    //}
    
    //@ObservedObject private var viewModel: AppViewModel
    @State private var letters: [Letter] = []
    @StateObject private var viewModel = AppViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                Image("158843898_10559251")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                
                VStack(spacing: 10) {
                    Text("Dyslexia Game")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
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
                        Text("Score: \(viewModel.totalScore)")
                    }
                    .padding()
                    .background(.white.opacity(0.75))
                    .cornerRadius(10)
                    
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
                            .multilineTextAlignment(.center)
                            .padding()
                            .background(.white.opacity(0.8))
                            .cornerRadius(10)
                    }
                }
                .padding()
            }
            .onReceive(viewModel.$letters) { newValue in
                letters = newValue
            }
        }
    }
}
#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
