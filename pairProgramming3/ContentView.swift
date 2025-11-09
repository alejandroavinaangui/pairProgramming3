//
//  ContentView.swift
//  pairProgramming3
//
//  Created by Alejandro Avina on 11/9/25.
//

import SwiftUI



let emojis = ["🇺🇸","🇺🇾","🇺🇿","🇻🇺","🇻🇦","🇻🇪","🇺🇸","🇺🇿","🇻🇺","🇻🇦","🇻🇪","🇺🇾"]


private var gridItems = [GridItem(.flexible()),GridItem(.flexible()),GridItem(.flexible())];

struct ContentView: View {

    @ObservedObject var viewModel: MapGame
    
    var body: some View {
          VStack {
              Text("Flag Memory Game")
                  .font(.largeTitle)
                  .foregroundColor(.green)
                  .fontWeight(.bold)
              
              ScrollView {
                  LazyVGrid(columns: gridItems, spacing: 10) {
                      ForEach(viewModel.cards) { card in
                          EmojiCard(card: card)
                              .onTapGesture {
                                  withAnimation(.easeInOut(duration: 0.5)) {
                                      viewModel.choose(card)
                                  }
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
           

    }
}

#Preview {
    ContentView(viewModel: MapGame())
}
