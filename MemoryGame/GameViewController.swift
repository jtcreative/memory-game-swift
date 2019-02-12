//
//  GameViewController.swift
//  MemoryGame
//
//  Created by James Timberlake on 2/12/19.
//  Copyright © 2019 James Timberlake. All rights reserved.
//

import UIKit

class GameViewController : UIViewController {
    let currentSettings : GameSettings
    var currentMatches = [Int:CardViewCell]()
    var cardInitializationIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        let stackView = UIStackView()
        stackView.axis = .vertical
        
        let backButton = UIButton()
        backButton.setImage(UIImage(named: "backNavButton"), for: .normal)
        backButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        //layout.itemSize = CGSize(width: 90, height: 120)
        let cardWidth = CGFloat(integerLiteral: (Int(UIScreen.main.bounds.size.width) / currentSettings.NumberOfColumns))
        let cardHeight = CGFloat(integerLiteral: (Int(UIScreen.main.bounds.size.height - 100) / currentSettings.NumberOfRows))
        layout.itemSize = CGSize(width: cardWidth * 0.8, height: cardHeight * 0.8)
        
        let gameView = UICollectionView(frame: stackView.frame, collectionViewLayout: layout)
        gameView.dataSource = self
        gameView.delegate = self
        gameView.register(CardViewCell.self, forCellWithReuseIdentifier: "CardCell")
        gameView.backgroundColor = .white
        
        view.addSubview(stackView)
        stackView.addArrangedSubview(backButton)
        stackView.addArrangedSubview(gameView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.topAnchor.constraint(equalTo: stackView.topAnchor, constant: 40).isActive = true
        backButton.leadingAnchor.constraint(equalTo: stackView.leadingAnchor).isActive = true
        backButton.widthAnchor.constraint(equalToConstant: 80).isActive = true
        backButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
    }
    
    required public init(gameSettings: GameSettings) {
        currentSettings = gameSettings
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func goBack() {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    func checkForMatch(cardCount:Int, cardCell:CardViewCell) {
        
        guard currentMatches.count < 2 else {
            //we haven't cleared the previous matches yet
            return
        }
        
        let containsCardAlready = currentMatches.contains(where: { (arg0) -> Bool in
            let (key, _) = arg0
            return key == cardCount
        })
        
        guard !containsCardAlready else {
            //we already have this card
            return
        }
        
        currentMatches[cardCount] = cardCell
        cardCell.revealCard()
        
        if currentMatches.count == 2 {
        
            let matchName = cardCell.card?.name
            
            for cells in currentMatches.values {
                if matchName != cells.card?.name {
                    //then this is not a match
                    clearUnmatchedCards()
                    return
                }
            }
            
            clearMatchCards()
        }
        
    }
    
    func clearUnmatchedCards() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { // Change `2.0` to the desired number of seconds.
            // Code you want to be delayed
            for cells in self.currentMatches.values {
                cells.hideCard()
            }
            self.currentMatches.removeAll()
        }
    }
    
    func clearMatchCards() {
        for cells in currentMatches.values {
           cells.completeMatch()
        }
        
        currentMatches.removeAll()
    }
    
}

extension GameViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return currentSettings.NumberOfColumns
    }
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return currentSettings.NumberOfRows
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCell", for: indexPath) as! CardViewCell
        cell.card = currentSettings.CardsIncluded[cardInitializationIndex]
        cell.card?.cardIndex = cardInitializationIndex
        cardInitializationIndex += 1
        return cell
    }
    
    
}

extension GameViewController : UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! CardViewCell
        if let cardIndex = cell.card?.cardIndex {
            checkForMatch(cardCount: cardIndex, cardCell: cell)
        }
    }
}
