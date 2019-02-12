//
//  CardView.swift
//  MemoryGame
//
//  Created by James Timberlake on 2/12/19.
//  Copyright © 2019 James Timberlake. All rights reserved.
//

import UIKit

class CardViewCell : UICollectionViewCell {

    var card : Card? {
        didSet {
            if let newCard = card {
                frontImage = UIImage(named: newCard.name)
            }
        }
    }
    
    override var isSelected: Bool {
        set {
            card?.isSelected = newValue
        }
        get {
            return card?.isSelected ?? false
        }
    }
    
    let backImage = UIImage(named: "allCardBacks")
    private var frontImage : UIImage?
    
    var cardView : UIImageView
    
    override init(frame: CGRect) {
        cardView = UIImageView()
        super.init(frame: frame)
        
        hideCard()
        contentView.addSubview(cardView)
        
        cardView.translatesAutoresizingMaskIntoConstraints = false
        cardView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        cardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        cardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        cardView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func revealCard() {
        cardView.image = frontImage
        card?.isSelected = true
    }
    
    public func hideCard() {
        cardView.image = backImage
        card?.isSelected = false
    }

    public func completeMatch() {
        card?.matched = true
        card?.isSelected = true
        isUserInteractionEnabled = false
    }
}
