//
//  ContentView.swift
//  TipKitDemo
//
//  Created by Serhii Lukashchuk on 2025-01-18.
//

import SwiftUI
import TipKit

struct ContentView: View {
    
    private let imageTip = ImageTip()
    
    @State private var imageName = "globe"
    @State private var textValue: String = "Hello, World!"
    @State var count = 0
    
    var body: some View {
        VStack {
            TipView(imageTip, arrowEdge: .bottom)
            
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

struct ImageTip: Tip {
    var title: Text {
        Text("This is Image view")
    }
    
    var message: Text? {
        Text("You can change it too")
    }
    
    var image : Image? {
        Image(systemName: "dog")
    }
}

#Preview {
    ContentView()
}
