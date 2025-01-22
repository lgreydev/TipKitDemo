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
    private let textTip = ImageTip()
    
    @State private var imageName = "globe"
    @State private var textValue: String = "Hello, World!"
    @State var count = 0
    
    var body: some View {
        VStack {
            TipView(imageTip, arrowEdge: .bottom) { action in
                switch action.id {
                case "change":
                    imageName = "moon"
                    textValue = "Zzzzz"
                    imageTip.invalidate(reason: .actionPerformed)
                case "close":
                    print("closed")
                    imageTip.invalidate(reason: .tipClosed)
                default:
                    break
                }
            }
            
            Image(systemName: imageName)
                .imageScale(.large)
                .foregroundStyle(.tint)
            
            Text(textValue)
                .popoverTip(textTip, arrowEdge: .top) { action in
                    switch action.id {
                    case "change":
                        textValue = "Hello!"
                        imageTip.invalidate(reason: .actionPerformed)
                    case "close":
                        print("closed")
                        imageTip.invalidate(reason: .tipClosed)
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
        Text("This is Image view")
    }
    
    var message: Text? {
        Text("You can change it too")
    }
    
    var image : Image? {
        Image(systemName: "dog")
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
        Text("This is Image view")
    }
    
    var message: Text? {
        Text("You can change it too")
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
