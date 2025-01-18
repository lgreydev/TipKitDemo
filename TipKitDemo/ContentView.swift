//
//  ContentView.swift
//  TipKitDemo
//
//  Created by Serhii Lukashchuk on 2025-01-18.
//

import SwiftUI

struct ContentView: View {
    
    @State private var imageName = "globe"
    @State private var textValue: String = "Hello, World!"
    @State var count = 0
    
    var body: some View {
        VStack {
            Image(systemName: imageName)
                .imageScale(.large)
                .foregroundStyle(.tint)
            
            Text(textValue)
            
            Button("\(count)") {
                count += 1
            }
            .buttonStyle(.borderedProminent)
            .font(.largeTitle)
            .bold()
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
