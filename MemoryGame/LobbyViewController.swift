//
//  ViewController.swift
//  MemoryGame
//
//  Created by James Timberlake on 2/11/19.
//  Copyright © 2019 James Timberlake. All rights reserved.
//

import UIKit

class LobbyViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        view.backgroundColor = .white
        let headerLabel = UILabel()
        
        let stackView = UIStackView()
        
        let threeByFourButton = UIButton()
        let fiveByTwoButton = UIButton()
        let fourByFourButton = UIButton()
        let fourByFiveButton = UIButton()
        
        stackView.axis = .vertical
        stackView.spacing = 15
        stackView.backgroundColor = .yellow
        headerLabel.textAlignment = .center
        headerLabel.text = "Memory Game"

        threeByFourButton.setTitle("3 x 4", for: .normal)
        threeByFourButton.tag = 0
        threeByFourButton.backgroundColor = .blue
        threeByFourButton.addTarget(self, action: #selector(goToGame), for: .touchUpInside)
        
        fiveByTwoButton.setTitle("5 x 2", for: .normal)
        fiveByTwoButton.tag = 1
        fiveByTwoButton.backgroundColor = .blue
        fiveByTwoButton.addTarget(self, action: #selector(goToGame), for: .touchUpInside)
        
        fourByFourButton.setTitle("4 x 4", for: .normal)
        fourByFourButton.tag = 2
        fourByFourButton.backgroundColor = .blue
        fourByFourButton.addTarget(self, action: #selector(goToGame), for: .touchUpInside)
        
        fourByFiveButton.setTitle("4 x 5", for: .normal)
        fourByFiveButton.tag = 3
        fourByFiveButton.backgroundColor = .blue
        fourByFiveButton.addTarget(self, action: #selector(goToGame), for: .touchUpInside)
        
        view.addSubview(stackView)
        stackView.addArrangedSubview(headerLabel)
        stackView.addArrangedSubview(threeByFourButton)
        stackView.addArrangedSubview(fiveByTwoButton)
        stackView.addArrangedSubview(fourByFourButton)
        stackView.addArrangedSubview(fourByFiveButton)

        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        headerLabel.topAnchor.constraint(equalTo: stackView.topAnchor, constant: 40).isActive = true
        headerLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor).isActive = true
        headerLabel.trailingAnchor.constraint(equalTo: stackView.trailingAnchor).isActive = true
        headerLabel.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        threeByFourButton.translatesAutoresizingMaskIntoConstraints = false
        threeByFourButton.centerXAnchor.constraint(equalTo: stackView.centerXAnchor).isActive = true
        threeByFourButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        fiveByTwoButton.translatesAutoresizingMaskIntoConstraints = false
        fiveByTwoButton.centerXAnchor.constraint(equalTo: stackView.centerXAnchor).isActive = true
        fiveByTwoButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        fourByFourButton.translatesAutoresizingMaskIntoConstraints = false
        fourByFourButton.centerXAnchor.constraint(equalTo: stackView.centerXAnchor).isActive = true
        fourByFourButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        fourByFiveButton.translatesAutoresizingMaskIntoConstraints = false
        fourByFiveButton.centerXAnchor.constraint(equalTo: stackView.centerXAnchor).isActive = true
        fourByFiveButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        
    }
    
    @objc func goToGame(sender: UIButton) {
      let tag = sender.tag
      
      var numberOfColumns:Int
      var numberOFRows:Int
        
        switch tag {
            case 0:
                numberOFRows = 4
                numberOfColumns = 3
                break
            case 1:
                numberOFRows = 2
                numberOfColumns = 5
                break
            case 2:
                numberOFRows = 4
                numberOfColumns = 4
                break
            case 3:
                numberOFRows = 4
                numberOfColumns = 5
                break
           default:
                numberOFRows = 4
                numberOfColumns = 3
                break
        }
        
      let totalSlots = numberOfColumns * numberOFRows
        
      let gameSettings = GameSettings(NumberOfColumns: numberOfColumns, NumberOfRows: numberOFRows, NumberOfChances: 99999, CardsIncluded: CardUtils.getCardForSpaceQuantity(totalSlots: totalSlots))
        
      let gameViewController = GameViewController(gameSettings: gameSettings)
        
      self.present(gameViewController, animated: true, completion: nil)
      
    }

}

