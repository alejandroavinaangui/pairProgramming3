//
//  ContentView.swift
//  pairProgramming3
//  AKA - The View
//  Created by Alejandro Avina on 11/9/25.
//

import SwiftUI


let emojis = ["🇺🇸","🇺🇾","🇺🇿","🇻🇺","🇻🇦","🇻🇪","🇺🇸","🇺🇿","🇻🇺","🇻🇦","🇻🇪","🇺🇾"]


private var gridItems = [GridItem(.flexible()),GridItem(.flexible()),GridItem(.flexible())];


struct ContentView: View {
    @ObservedObject var viewModel: MapGame
    @State private var pulsingCardID: Int? = nil // tracks what card should pulse
    
    
    var body: some View {
        VStack(spacing: 12) {
              
              Text("Flag Memory Game")
                  .font(.largeTitle)
                  .foregroundColor(.green)
                  .fontWeight(.bold)
              
              Text(viewModel.statusMessage)
                  .font(.headline)
                  .padding(.horizontal)
                  .frame(maxWidth: .infinity, alignment: .center)


              ScrollView {
                  LazyVGrid(columns: gridItems, spacing: 10) {
                      ForEach(viewModel.cards) { card in
                          EmojiCard(card: card)
                          // the overlay appears only on the card tapped
                              .overlay(
                                Group {
                                    if pulsingCardID == card.id {
                                        RectPulse()
                                            .padding(2)
                                    }
                                }
                              
                            )
                              .onTapGesture {
                                  withAnimation(.easeInOut(duration: 0.5)) {
                                      viewModel.choose(card)
                                  }
                                  pulsingCardID = card.id // marks what card to pulse
                              }
                      }
                  }
                  .padding()
              }
          }
      }
  }
    

struct EmojiCard: View{
    var card:MemoryGame.Card

    var body: some View {
        ZStack{
            let shape = Rectangle().foregroundColor(.green).frame(width:100);
           
            if card.isFaceUp {
                shape.opacity(0)
                Text(card.content).font(.system(size:70) )
                

            }
            else{
                shape.opacity(1)
            }
            
        }.padding(.horizontal)

        .frame(width:80,height:100)
        .scaleEffect(card.isFaceUp ? 1.5 : 1.0)
        .animation(.easeInOut(duration: 1), value: card.isFaceUp)
        .accessibilityLabel(card.isFaceUp ? "Face up \(card.content)" : "Face down card")

    }
}

// added a struct here for the pulse animation
struct RectPulse: View {
    @State private var animate = false
    
    var body: some View {
        Rectangle()
            .stroke(.white, lineWidth: 10) // white lines that pulse
            .scaleEffect(animate ? 0.25 : 1.10) // this grows the pulse
            .opacity(animate ? 0.0 : 1.0) // this changes the visiblity
            .onAppear{
// this is the trigger for the animation - can toggle the duration of the pulse and how many times the animation pulses.
                withAnimation(.easeOut(duration: 0.2) .repeatCount(2, autoreverses: false)) {
                    animate = true
                }
            }
            .allowsHitTesting(false) // let's the tap pass
    }
}

#Preview {
    ContentView(viewModel: MapGame())
}
