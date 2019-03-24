//
//  ViewController.swift
//  Concentration
//
//  Created by Jeremy Lee on 3/21/19.
//  Copyright © 2019 Jeremy Lee. All rights reserved.
//

import UIKit

/// This class represents a controller for responding to a player according to the rules of a game of Concentration. This class implements the UICollectionViewDelegate, UICollectionViewDataSource, and UICollectionViewDelegateFlowLayout methods as it uses a UICollectionView to simulate a table of Cards. This controller gives the user the ability to select a Card by touching it on the screen and allows the user to intiate a new game at any point by touching the new game button.
class ViewController: UIViewController {
    // MARK: Properties
    // The number of pairs of Cards in the game.
    private var numPairs: Int {
        return 6
    }
    
    // The ConcentrationGame object.
    private lazy var game = ConcentrationGame(numPairs: numPairs)
    
    // A nested list of emojis, which represent the possible themes for the game.
    private var themes: [[String]] = [["🐶", "🐱", "🐭", "🐹", "🐰", "🦊"],
                                      ["🍏", "🍎", "🍐", "🍊", "🍋", "🍌"],
                                      ["⚽️", "🏀", "🏈", "⚾️", "🎾", "🏐"],
                                      ["🚗", "🚕", "🚙", "🚌", "🚎", "🏎"],
                                      ["😈", "👹", "👺", "🤡", "👻", "💀"],
                                      ["🐜", "🦗", "🕷", "🕸", "🦂", "🐢"]]
    
    // The selected theme to use.
    private var selectedTheme: [String]?
    
    // MARK: Subviews
    // UICollectionView for displaying the Cards in the game.
    private var cardsCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return cv
    }()

    // UILabel for displaying the name of the game ("Concentration).
    private var gameTitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.backgroundColor = UIColor.clear
        label.text = "Concentration"
        label.setFontSize(size: 40)
        label.textColor = UIColor.white
        label.textAlignment = .center
        return label
    }()
    
    // UILabel for displaying the current score of the game.
    private var scoresLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.backgroundColor = UIColor.clear
        label.setFontSize(size: 30)
        label.textColor = UIColor.white
        label.textAlignment = .center
        return label
    }()
    
    // A UIButton for initiating a new game.
    private var newGameButton: UIButton = {
        let button = UIButton()
        button.setTitle(" New Game ", for: .normal)
        button.titleLabel?.setFontSize(size: 30)
        button.titleLabel?.textColor = UIColor.black
        button.backgroundColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        button.layer.cornerRadius = 10.0
        return button
    }()
    
    // MARK: Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Select a theme
        chooseTheme()
        
        // Add gameTitleLabel to view and position at top of screen
        view.addSubview(gameTitleLabel)
        gameTitleLabel.setAnchors(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, right: view.rightAnchor, height: 50)
        
        // Add scoresLabel to view and position just below gameTitleLabel
        view.addSubview(scoresLabel)
        scoresLabel.setAnchors(top: gameTitleLabel.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, height: 50)
        setScoresLabel()
        
        // Add newGameButton to view at bottom of screen and add target for initializing new game.
        view.addSubview(newGameButton)
        newGameButton.sizeToFit()
        newGameButton.setAnchors(bottom: view.safeAreaLayoutGuide.bottomAnchor)
        newGameButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: (view.frame.width - newGameButton.frame.width) / 2).isActive = true
        newGameButton.addTarget(self, action: #selector(startNewGame), for: .touchUpInside)
        
        // Setup cardsCollection delegate and data source
        cardsCollection.delegate = self
        cardsCollection.dataSource = self
        cardsCollection.register(CardCollectionViewCell.self, forCellWithReuseIdentifier: "cardCell")
        
        // Add cardsCollection to view between scoresLabel and newGameButton
        view.addSubview(cardsCollection)
        cardsCollection.setAnchors(bottom: newGameButton.topAnchor, left: view.leftAnchor, right: view.rightAnchor)
        cardsCollection.topAnchor.constraint(equalTo: scoresLabel.bottomAnchor, constant: 10).isActive = true
    }
    
    /// Updates the game score displayed in the scoresLabel.
    private func setScoresLabel() {
        scoresLabel.text = "Score: \(game.score)"
    }
    
    /// Selects a theme from the list of possible themes.
    private func chooseTheme() {
        let randomIndex = Int.random(in: themes.indices)
        selectedTheme = themes[randomIndex]
    }
    
    /// Initiates a new game on screen by choosing a new theme and reinitializing game to a new ConcentrationGame object.
    @objc private func startNewGame() {
        chooseTheme()
        game = ConcentrationGame(numPairs: numPairs)
        cardsCollection.reloadData()
        setScoresLabel()
    }

}

// MARK: UICollectionViewDelegate and DataSource methods.
extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    // The spacing between cells in the UICollectionView.
    private var cardSpacing: CGFloat {
        return 5.0
    }
    
    // The number of cells per row in the above UICollectionView.
    private var cardsPerRow: Int {
        return 4
    }
    // The number of rows of cells in the above UICollectionView.
    private var numberOfRowsOfCards: Int {
        return numPairs * 2 / cardsPerRow + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return game.cards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cardWidth = (UIScreen.main.bounds.width - CGFloat(numberOfRowsOfCards + 1) * cardSpacing) / CGFloat(cardsPerRow)
        return CGSize(width: cardWidth, height: 1.25 * cardWidth)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return cardSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return cardSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cardCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cardCell", for: indexPath) as! CardCollectionViewCell
        
        let card = game.cards[indexPath.row]
        
        // Hide cell if card at indexPath has been matched
        if card.isMatched {
            cardCell.hideCard()
        // Otherwise display the cell with an emoji if the card at the indexPath is face up
        } else if card.isFaceUp {
            let emoji = selectedTheme?[card.identifier] ?? ""
            cardCell.showEmoji(emoji: emoji)
        // Otherwise display the cell without an emoji since it is face down
        } else {
            cardCell.hideEmoji()
        }
        
        return cardCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // Initiate chooseCard method when a user touches a cell
        game.chooseCard(index: indexPath.row)
        
        // Update the scores label
        setScoresLabel()
        
        // Reload the cardsCollection to reflect any changes in the face up or face down statuses of the cards
        collectionView.reloadData()
    }
    
    
}
