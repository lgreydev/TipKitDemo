//
//  ContentView.swift
//  TipKitDemo
//
//  Created by Serhii Lukashchuk on 2025-01-18.
//

import SwiftUI
import TipKit

struct ContentView: View {
       
    private let tipGroup = TipGroup {
        TextTip()
        ImageTip()
    }
    
    private let countTip = CountTip()
    
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
            
            TipView(countTip)
            
            Button("\(count)") {
                count += 1
                CountTip.isButtonTapped.toggle()
                Task {
                    await CountTip.didTriggerButtonEvent.donate()
                }
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

struct CountTip: Tip {
    var title: Text {
        Text("How tired are you?")
    }
    
    var message: Text? {
        Text("How many hours do you want to sleep?")
    }
    
    var image : Image? {
        Image(systemName: "hand.tap.fill")
    }
    
    @Parameter
    static var isButtonTapped: Bool = false
    
    static let  didTriggerButtonEvent = Event(id: "didTriggerButtonEvent")
    
    var rules: [Rule] {
        [
            #Rule(Self.$isButtonTapped) {
                $0 == true
            },
            #Rule(Self.didTriggerButtonEvent) {
                $0.donations.count > 5
            }
        ]
    }
}

#Preview {
    ContentView()
}
