//
//  SettingScreen.swift
//  dyslexia
//
//  Created by Elizabeth R. Mealing on 3/17/26.
//
import SwiftUI
struct SettingsScreen: View {
    @ObservedObject var viewModel: AppViewModel
    
    var body: some View {
        Form {
            Section("Word Length Range") {
                VStack(alignment: .leading) {
                    Text("Minimum Length: \(Int(viewModel.minWordLength))")
                    Slider(value: $viewModel.minWordLength, in: 3...12, step: 1)
                }
                
                VStack(alignment: .leading) {
                    Text("Maximum Length: \(Int(viewModel.maxWordLength))")
                    Slider(value: $viewModel.maxWordLength, in: 3...12, step: 1)
                }
            }
            
            Section("Letter Background Color") {
                VStack(alignment: .leading) {
                    Text("Red: \(viewModel.redValue, specifier: "%.2f")")
                    Slider(value: $viewModel.redValue, in: 0...1)
                }
                
                VStack(alignment: .leading) {
                    Text("Green: \(viewModel.greenValue, specifier: "%.2f")")
                    Slider(value: $viewModel.greenValue, in: 0...1)
                }
                
                VStack(alignment: .leading) {
                    Text("Blue: \(viewModel.blueValue, specifier: "%.2f")")
                    Slider(value: $viewModel.blueValue, in: 0...1)
                }
                
                RoundedRectangle(cornerRadius: 12)
                    .fill(viewModel.letterBackgroundColor)
                    .frame(height: 60)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(.black, lineWidth: 1)
                    )
            }
        }
        .navigationTitle("Settings")
    }
}

