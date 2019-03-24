//
//  CustomExtensions.swift
//  Concentration
//
//  Created by Jeremy Lee on 3/22/19.
//  Copyright © 2019 Jeremy Lee. All rights reserved.
//

import UIKit

extension UIView {
    
    func setAnchors(top: NSLayoutYAxisAnchor? = nil, bottom: NSLayoutYAxisAnchor? = nil, left: NSLayoutXAxisAnchor? = nil, right: NSLayoutXAxisAnchor? = nil, width: CGFloat? = nil, height: CGFloat? = nil) {
        translatesAutoresizingMaskIntoConstraints = false
        
        if let newTop = top {
            topAnchor.constraint(equalTo: newTop).isActive = true
        }
        if let newBottom = bottom {
            bottomAnchor.constraint(equalTo: newBottom).isActive = true
        }
        if let newLeft = left {
            leftAnchor.constraint(equalTo: newLeft).isActive = true
        }
        if let newRight = right {
            rightAnchor.constraint(equalTo: newRight).isActive = true
        }
        if let newHeight = height {
            if top == nil || bottom == nil {
                heightAnchor.constraint(equalToConstant: newHeight).isActive = true
            }
        }
        if let newWidth = width {
            if left == nil || right == nil {
                widthAnchor.constraint(equalToConstant: newWidth).isActive = true
            }
        }
    }
        
}

extension UILabel {
    func setFontSize(size: CGFloat) {
        font = UIFont(name: "Arial Rounded MT Bold", size: size)
    }
}
