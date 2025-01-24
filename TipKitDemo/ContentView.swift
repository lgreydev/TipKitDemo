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
    private let textTip = TextTip()
    
    private let tipGroup = TipGroup {
        TextTip()
        ImageTip()
    }
    
    @State private var imageName = "globe"
    @State private var textValue = "Hello, World!"
    @State var count = 0
    
    var body: some View {
        VStack {
            TipView(tipGroup.currentTip as? ImageTip, arrowEdge: .bottom) { action in
                switch action.id {
                case "change":
                    imageName = "moon"
                    textValue = "Zzzzz"
                    tipGroup.currentTip?.invalidate(reason: .actionPerformed)
                case "close":
                    print("closed")
                    tipGroup.currentTip?.invalidate(reason: .tipClosed)
                default:
                    break
                }
            }
            
            Image(systemName: imageName)
                .imageScale(.large)
                .foregroundStyle(.tint)
            
            Text(textValue)
                .popoverTip(tipGroup.currentTip as? TextTip, arrowEdge: .top) { action in
                    switch action.id {
                    case "change":
                        textValue = "Hello!"
                        tipGroup.currentTip?.invalidate(reason: .actionPerformed)
                    case "close":
                        print("closed")
                        tipGroup.currentTip?.invalidate(reason: .tipClosed)
                    default:
                        break
                    }
                }
            
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
        Text("Rest here and take a nap")
    }
    
    var message: Text? {
        Text("You've seen too many")
    }
    
    var image : Image? {
        Image(systemName: "moon")
    }
    
    var actions: [Action] {
        [
            Action(id: "change", title: "Go to sleep"),
            Action(id: "close", title: "Close")
        ]
    }
}

struct TextTip: Tip {
    var title: Text {
        Text("Take a little rest")
    }
    
    var message: Text? {
        Text("You need to get some sleep.")
    }
    
    var image : Image? {
        Image(systemName: "textformat.alt")
    }
    
    var actions: [Action] {
        [
            Action(id: "change", title: "Go to sleep"),
            Action(id: "close", title: "Close")
        ]
    }
}

#Preview {
    ContentView()
}
