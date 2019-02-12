//
//  CardUtils.swift
//  MemoryGame
//
//  Created by James Timberlake on 2/12/19.
//  Copyright © 2019 James Timberlake. All rights reserved.
//

class CardUtils {
    
    private static let availableCards = [
        Card(frontImageName: "memoryBatCardFront"),
        Card(frontImageName: "memoryCatCardFront"),
        Card(frontImageName: "memoryCowCardFront"),
        Card(frontImageName: "memoryDragonFront"),
        Card(frontImageName: "memoryGarbageManCardFront"),
        Card(frontImageName: "memoryGhostDogCardFront"),
        Card(frontImageName: "memoryHenCardFront"),
        Card(frontImageName: "memoryHorseCardFront"),
        Card(frontImageName: "memoryPigCardFront"),
        Card(frontImageName: "memorySpiderCardFront"),
        ]
    
    static func getCardForSpaceQuantity(totalSlots: Int) -> [Card] {
        
        let numberOfCardsNeeded = totalSlots / 2
        
        guard numberOfCardsNeeded > 0, totalSlots % 2 == 0, numberOfCardsNeeded <= availableCards.count else {
            print("Not a valid slot number")
            return [Card]()
        }
        
        let shuffledCards = availableCards.shuffled()
        
        var returnedArray = [Card]()
        
        for i in 0..<numberOfCardsNeeded {
            returnedArray.append(shuffledCards[i].copy() as! Card)
            returnedArray.append(shuffledCards[i].copy() as! Card)
        }
        
        return returnedArray.shuffled()
    }
}
