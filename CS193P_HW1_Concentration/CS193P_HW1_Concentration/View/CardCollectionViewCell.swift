//
//  CardCollectionViewCell.swift
//  Concentration
//
//  Created by Jeremy Lee on 3/21/19.
//  Copyright © 2019 Jeremy Lee. All rights reserved.
//

import UIKit

class CardCollectionViewCell: UICollectionViewCell {
    var cardLabel: UILabel = {
        let label = UILabel()
        
        label.layer.cornerRadius = 10.0
        label.layer.masksToBounds = true
        label.textAlignment = .center
        label.font = UIFont(name: "Arial", size: 30)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(cardLabel)
        cardLabel.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func showEmoji(emoji: String) {
        cardLabel.backgroundColor = UIColor.white
        cardLabel.text = emoji
    }
    
    func hideEmoji() {
        cardLabel.backgroundColor = #colorLiteral(red: 1, green: 0.4932718873, blue: 0.4739984274, alpha: 1)
        cardLabel.layer.borderWidth = 5.0
        cardLabel.layer.borderColor = UIColor.white.cgColor
        cardLabel.backgroundColor = #colorLiteral(red: 1, green: 0.4932718873, blue: 0.4739984274, alpha: 1)
        cardLabel.text = ""
    }
    
    func hideCard() {
        self.backgroundColor = UIColor.clear
        cardLabel.text = ""
        cardLabel.backgroundColor = UIColor.clear
        cardLabel.layer.borderWidth = 0
        
    }
    
}
