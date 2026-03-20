//
//  HistoryScreen.swift
//  dyslexia
//
//  Created by Elizabeth R. Mealing on 3/17/26.
//
import SwiftUI
struct HistoryScreen: View {
    @ObservedObject var viewModel: AppViewModel
    
    var body: some View {
        VStack(spacing: 16) {
            Text("Game History")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            VStack(spacing: 10) {
                Button("Sort by Word") {
                    viewModel.sortHistoryByWord()
                }
                .buttonStyle(.bordered)
                
                Button("Sort by Points") {
                    viewModel.sortHistoryByPoints()
                }
                .buttonStyle(.bordered)
                
                Button("Sort by Moves") {
                    viewModel.sortHistoryByMoves()
                }
                .buttonStyle(.bordered)
                
                Button("Sort by Seconds") {
                    viewModel.sortHistoryBySeconds()
                }
                .buttonStyle(.bordered)
            }
            
            ScrollView {
                LazyVStack(spacing: 12) {
                    ForEach(viewModel.gameHistory) { record in
                        VStack(alignment: .leading, spacing: 6) {
                            Text(record.word)
                                .font(.headline)
                            
                            Text("Points: \(record.points)")
                            Text("Moves: \(record.moves)")
                            Text("Seconds: \(record.seconds)")
                            Text(record.points == 0 ? "Status: Incomplete" : "Status: Complete")
                                .fontWeight(.bold)
                        }
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(record.points == 0 ? Color.red.opacity(0.2) : Color.green.opacity(0.2))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(record.points == 0 ? .red : .green, lineWidth: 2)
                        )
                        .cornerRadius(10)
                    }
                }
                .padding(.horizontal)
            }
        }
        .padding()
        .navigationTitle("History")
    }
}

