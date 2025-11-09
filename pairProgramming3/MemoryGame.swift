//
//  MemoryGame.swift
//  pairProgramming3
//
//  Created by Alejandro Avina on 11/9/25.
//
import Foundation

struct MemoryGame {
    
    private(set) var cards: Array <Card>
    private(set) var numberOfPairs: Int
    
    
    struct Card: Identifiable {
        var content: String
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var id:Int
    }
    
    
    mutating func chooseCard(card:Card){
        
        for index in cards.indices {
            if cards[index].id == card.id{
                cards[index].isFaceUp.toggle()
            }
        }
        
    }
    
    
    init(numberOfPairsOfCards: Int, contentFactory: (Int)-> String) {
        cards = []
        numberOfPairs = numberOfPairsOfCards
        
        for index in 0..<numberOfPairsOfCards{
            let content = contentFactory(index)
            cards.append(Card(content: content, id: index * 2))
            
            cards.append(Card(content: content, id: index * 2 + 1))
        }
        cards.shuffle()
    }
    
}
