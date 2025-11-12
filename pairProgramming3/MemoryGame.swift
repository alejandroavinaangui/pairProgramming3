//
//  MemoryGame.swift
//  pairProgramming3
//  AKA - the Model
//  Created by Alejandro Avina on 11/9/25.
//
import Foundation

struct MemoryGame {
    
    private(set) var cards: [Card]
    private(set) var numberOfPairs: Int
    
    //added
    private var indexOfFaceUpCard: Int?
    
   //added
    enum Outcome {
        case firstFlip
        case match
        case mismatch
    }
    
    
    struct Card: Identifiable {
        var content: String
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var id:Int
    }
    
    //added 29 - 59
    mutating func chooseCard (card: Card) -> Outcome {
        guard let chosenIndex = cards.firstIndex(where: { $0.id == card.id }) else { return .firstFlip }
        guard !cards[chosenIndex].isMatched, !cards[chosenIndex].isFaceUp else { return . firstFlip }
        
        
        if let firstIndex = indexOfFaceUpCard {
            cards[chosenIndex].isFaceUp = true
            if cards[firstIndex].content == cards[chosenIndex].content {
                cards[firstIndex].isMatched = true
                cards[chosenIndex].isMatched = true
                indexOfFaceUpCard = nil
                return .match
            } else {
                indexOfFaceUpCard = nil
                return .mismatch
                
            }
        } else {
            
            indexOfFaceUpCard = chosenIndex
            cards[chosenIndex].isFaceUp = true
            return .firstFlip
            }
        }
    // added
    mutating func flipDownAllNonMatched() {
        for i in cards.indices where !cards[i].isMatched {
            cards[i].isFaceUp = false
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
