//
//  DeckOfCards.swift
//  HigherOrLower
//
//  Created by Jason Flooks on 03/02/2015.
//  Copyright (c) 2015 Rmando. All rights reserved.
//

import Foundation

open class DeckOfCards {

enum Rank: Int {
    case ace = 1
    case two, three, four, five, six, seven, eigth, nine, ten
    case jack, queen, king
    func simpleDescription() -> String {
        switch self {
        case .ace: return "ace"
        case .jack: return "jack"
        case .queen: return "queen"
        case .king: return "king"
        default: return String(self.rawValue)
        }
    }
}

enum Suit: Int {
    case spades = 0
    case hearts, diamonds, clubs
    func simpleDescription() -> String {
        switch self {
        case .spades: return "spades"
        case .hearts: return "hearts"
        case .diamonds: return "diamonds"
        case .clubs: return "clubs"
        }
    }
    
    func color() -> String {
        switch self {
        case .spades: return "black"
        case .clubs: return "black"
        case .hearts: return "red"
        case .diamonds: return "red"
            
        }
    }
}

struct Card {
    var rank: Rank
    var suit: Suit
    func simpleDescription() -> String {
        return "\(rank.simpleDescription())_of_\(suit.simpleDescription())"
    }
    
    func fullDeckOfCards () -> [Card] {
        var cards = [Card]()
        for i in Suit.spades.rawValue...Suit.clubs.rawValue {
            if let covertedSuit = Suit(rawValue: i) {
                let suit = covertedSuit
                for j in Rank.ace.rawValue...Rank.king.rawValue {
                    if let covertedRank = Rank(rawValue: j) {
                        let rank = covertedRank
                        let card = Card(rank: rank, suit: suit)
                        //cards += card
                        cards.append(card)
                    }
                }
            }
        }
        return cards
    }
}

}

extension Array {
    func shuffled() -> [Element] {
        var list = self
        for _ in 0..<50 {
            for i in 0..<(list.count - 1) {
                let j = Int(arc4random_uniform(UInt32(list.count - i))) + i
                guard i != j else { continue }
                list.swapAt(i, j)
            }
        }
        return list
    }
    
}


// Local variables for Higher or Lower game
//func initialSetUp () {
    var aCard = DeckOfCards.Card(rank: .three, suit: .spades)
    //let cardDescription = aCard.simpleDescription()
    var fullDeck = aCard.fullDeckOfCards()
    var shuffledDeck = fullDeck.shuffled()
    var initialCardSwapped = false
    var currentPlayingCard = 1
//}








/*  OLD CODE

func returnCardFileName(pValue: UInt32, pSuit: UInt32) -> String {

var faceValue:String
var suitValue:String

if pValue == 11
  {faceValue = "jack"}
else if pValue == 12
  {faceValue = "queen"}
else if pValue == 13
  {faceValue = "king"}
else if pValue == 1
  {faceValue = "ace"}
else
  {faceValue = toString(pValue)}

if pSuit == 1
  {suitValue = "clubs"}
else if pSuit == 2
  {suitValue = "diamonds"}
else if pSuit == 3
  {suitValue = "hearts"}
else
  {suitValue = "spades"}

return faceValue + "_of_" + suitValue

}
*/
//var randomCardValue = arc4random_uniform(13) + 1
//var randomCardSuit = arc4random_uniform(4) + 1
//self.initialCardImageView.image = UIImage(named: returnCardFileName(randomCardValue, pSuit: randomCardSuit))



