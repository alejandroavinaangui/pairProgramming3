//
//  MapGame.swift
//  pairProgramming3
//
//  Created by Alejandro Avina on 11/9/25.
//


import SwiftUI

class MapGame: ObservableObject {
    @Published private var model: MemoryGame = CreateMemoryGame()
    // added
    @Published var statusMessage: String = "Flip two cards to find a pair"
    
    static func CreateMemoryGame()->MemoryGame{
        return MemoryGame(numberOfPairsOfCards:6,contentFactory: makeContent)
    }
    
    static func makeContent(index: Int)-> String{
        let emojis = ["🇺🇸","🇺🇾","🇺🇿","🇻🇺","🇻🇦","🇻🇪"]
        return emojis[index]
        
    }
    
    // var cards: Array<MemoryGame.Card> { model.cards } <--changed this
    var cards: [ MemoryGame.Card ] { model.cards }
    var pairs: Int { model.numberOfPairs }
    
    func choose(_ card: MemoryGame.Card) { // { model.chooseCard(card:card) }
        let outcome = model.chooseCard(card: card)
        switch outcome {
        case .firstFlip:
            statusMessage = "Pick the matching card"
            objectWillChange.send()
            
        case .match:
            statusMessage = "Correct!"
            objectWillChange.send()
            
        case .mismatch:
            statusMessage = "Incorrect - Try Again"
            model.flipDownAllNonMatched()
            objectWillChange.send()
        }
    }
    
    func resetGame() {
        model = Self.CreateMemoryGame()
        statusMessage = "Flip two cards to find a pair"
    }
}
