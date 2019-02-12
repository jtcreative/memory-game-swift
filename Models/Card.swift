//
//  Card.swift
//  MemoryGame
//
//  Created by James Timberlake on 2/12/19.
//  Copyright © 2019 James Timberlake. All rights reserved.
//

class Card {
    var isSelected : Bool
    var matched: Bool
    var cardIndex: Int?
    private(set) var name: String
    
    required public init(frontImageName:String) {
        name = frontImageName
        isSelected = false
        matched = false
    }
    
    func equals (card: Card)->Bool {
        return name == card.name
    }
    
    func copy() -> Any {
        let copy = Card(frontImageName: name)
        return copy
    }
}
