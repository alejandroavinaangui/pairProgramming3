//
//  MapGame.swift
//  pairProgramming3
//
//  Created by Alejandro Avina on 11/9/25.
//


import SwiftUI

class MapGame: ObservableObject {
    @Published private var model: MemoryGame = CreateMemoryGame()
    
    static func CreateMemoryGame()->MemoryGame{
        return MemoryGame(numberOfPairsOfCards:6,contentFactory: makeContent)
    }
    
    static func makeContent(index: Int)-> String{
        let emojis = ["🇺🇸","🇺🇾","🇺🇿","🇻🇺","🇻🇦","🇻🇪"]
        
        return emojis[index]

    }
    
    var cards: Array<MemoryGame.Card>{
        model.cards
    }
    
    var pairs: Int{
        model.numberOfPairs;
    }
    
    func choose(_ card: MemoryGame.Card){
        model.chooseCard(card:card)
    }
    
    
}
