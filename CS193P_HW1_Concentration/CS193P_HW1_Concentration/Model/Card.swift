//
//  Card.swift
//  Concentration
//
//  Created by Jeremy Lee on 3/21/19.
//  Copyright © 2019 Jeremy Lee. All rights reserved.
//

import UIKit


 /// This class represents a playing Card in a card game. Every card has a unique identifier (an int) and properties signifying whether the card is face up or face down and whether the card is matched or not (Both Bools).
struct Card {
    // A boolean which is true if this Card is face up, or false otherwise.
    var isFaceUp: Bool
    
    // A boolean which is false if this Card has not been matched, or false otherwise.
    var isMatched: Bool
    
    // An int representing the unique identifier of this Card.
    private(set) var identifier: Int
    
    // A static counter for keeping track of the next unique identifier.
    private static var identifierCount = -1
    
    // An int which is the number of times this Card has been mismatched with another Card.
    private(set) var numMismatches: Int
    
    /// Constructs a new Card object with its identifier initialized to the next available unique identifer.
    /// - Parameters: None
    init() {
        self.identifier = Card.setIdentifier()
        self.isFaceUp = false
        self.isMatched = false
        self.numMismatches = 0
    }
    
    /// Returns the next availalbe unique identifier as an int.
    /// - Parameters: None.
    /// - returns: An int which is the next available unique identifier.
    private static func setIdentifier() -> Int {
        identifierCount += 1
        return identifierCount
    }
    
    /// Resets the identifer count of the Card class to -1.
    static func resetIdentifierCount() {
        identifierCount = -1
    }
    
    /// Flips the isMatched property of this Card to true
    mutating func cardMatched() {
        self.isMatched = true
    }
    
    /// Increments number of times this Card has been mismatched by 1
    mutating func cardMismatched() {
        self.numMismatches += 1
    }
    
}

extension Card: Equatable {
    // Returns true if Card on left hand side of == has same identifier as Card on right hand side of ==
    static func ==(lhs: Card, rhs: Card) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
}

