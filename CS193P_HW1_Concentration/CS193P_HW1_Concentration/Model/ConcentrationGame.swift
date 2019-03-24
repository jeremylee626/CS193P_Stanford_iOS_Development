//
//  ConcentrationGame.swift
//  Concentration
//
//  Created by Jeremy Lee on 3/21/19.
//  Copyright © 2019 Jeremy Lee. All rights reserved.
//

import UIKit

/// This class represents the rules of the card game Concentration, which is a game where a player attempts to find matching pairs of cards on a table of cards. Each card on the table has exactly one matching card also on the table. All cards begin facedown and the palyer is allowed to flip two cards face up each turn. If the two flipped cards match, the player earns 2 points and the cards are removed from the game. However, if they do not match, the player loses 1 point for every time each card has been mismatched previously and the cards are flipped back to face down.
class ConcentrationGame {
    // The score of this ConcentrationGame as an int.
    private(set) var score: Int = 0
    // The number of card flips in this ConcentrationGame as an int.
    private var flipCount = 0
    // The Cards in this ConcentrationGame.
    private(set) var cards = [Card]()
    // The indices (in cards) of the face up Cards in this ConcentrationGame.
    private var faceUpIndices = [Int]()
    
    /// Constructs a new ConcentrationGame with a list of Cards, which have been randomly ordered. The number of Cards in cards is equal to two times the number of pairs input into the constructor.
    /// - Parameters:
    ///     - numPairs: An int representing the number of pairs of Cards to initialize the game with.
    init(numPairs: Int) {
        Card.resetIdentifierCount()
        self.cards = createCards(numPairs: numPairs)
    }
    
    /// Private method which creates an array of Cards. The number of cards created is 2 times the input number of pairs (numPairs). Each Card in the array has exactly one matching Card (same identifiers) also in the array.
    /// - Parameters:
    ///     1) numPairs: an Int representing the number of pairs of Cards to put in the returned array.
    /// - Returns: An array of Cards.
    private func createCards(numPairs: Int) -> [Card] {
        var cardsArray = [Card]()
        for _ in 0..<numPairs {
            let card = Card()
            cardsArray += [card, card]
        }
        return shuffleCards(cards: cardsArray)
    }
    
    /// Private method which takes an input array of Cards and returns a new Array of Cards, which is the result of randomly ordering the Cards in the input array.
    /// - Parameters:
    ///     1) cards: An array of Cards to shuffle.
    /// - Returns: A shuffled array of Cards.
    private func shuffleCards(cards: [Card]) -> [Card] {
        var cards = cards
        var shuffledCards = [Card]()
        for _ in cards.indices {
            let randomIndex = Int.random(in: cards.indices)
            shuffledCards.append(cards.remove(at: randomIndex))
        }
        return shuffledCards
    }
    
    /// Method for choosing a Card in this ConcentrationGame and flipping it face up. If there are two face up Cards in the game when this method is called, those Cards will be flipped face down. If there is one face up Card, the Card at the input index and that face up card will be checked for matching identifiers using the checkForMatch method.
    /// - Parameters:
    ///     1) index: An Int, which is the index of the chosen Card to flip.
    /// - Returns: Nothing.
    func chooseCard(index: Int) {
        // Make sure the Card at the input index is not already face up and has not already been matched
        if !faceUpIndices.contains(index) && !cards[index].isMatched {
            // Flip the selected card face up
            cards[index].isFaceUp = true
            
            // If there are two other face up cards
            if faceUpIndices.count == 2 {
                // Flip the two other face up cards face down
                for i in faceUpIndices {
                    cards[i].isFaceUp = false
                }
                faceUpIndices = []
            // Otherwise, if there is one other face up card
            } else if faceUpIndices.count == 1 {
                // Check if that card and the selected card match
                checkForMatch(c1Index: faceUpIndices.first!, c2Index: index)
            }
            faceUpIndices.append(index)
            flipCount += 1
        }
        
    }
    
    /// Checks if two cards at the input indices match according to their identifiers. If the cards match, this ConcentrationGame's score is incremented by 2. If they do not match, the score is decremented by the total number of times the two selected Cards have been mismatched previously. This method will do nothing if the two input indices are the same.
    /// - Parameters:
    ///     1) c1Index: An Int, which is the index of the first Card in this game's cards
    ///     2) c2Index: An Int, which is the index of the second Card in this game's cards
    /// - Returns: Nothing
    func checkForMatch(c1Index: Int, c2Index: Int) {
        if (c1Index == c2Index) {
            return
        }
        if (cards[c1Index] == cards[c2Index]) {
            score += 2
            cards[c1Index].isMatched = true
            cards[c2Index].isMatched = true
        } else {
            score -= (cards[c1Index].numMismatches + cards[c2Index].numMismatches)
            cards[c1Index].cardMismatched()
            cards[c2Index].cardMismatched()
        }
    }
    
}
