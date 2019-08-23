//
//  UIButtonSelectorRounded.swift
//  PomangamiOS
//
//  Created by 최민섭 on 23/08/2019.
//  Copyright © 2019 최민섭. All rights reserved.
//

import UIKit

class UIButtonSelectorRounded: UIButton {
    override var isHighlighted: Bool {
        didSet {
            if isHighlighted {
                self.backgroundColor = .dustyOrange
                self.layer.borderWidth = 0
            } else {
                self.backgroundColor = .white
                self.layer.borderColor = UIColor.dustyOrange.cgColor
                self.layer.borderWidth = 1.5
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setAttributedTitle(
            attributedString(
                from: self.currentTitle ?? "",
                textColor: .dustyOrange ),
            for: .normal)
        self.setAttributedTitle(
            attributedString(
                from: self.currentTitle ?? "",
                textColor: .white),
            for: .highlighted)
//        self.widthAnchor.constraint(equalToConstant: 87).isActive = true
//        self.heightAnchor.constraint(equalToConstant: 41).isActive = true
//        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    override func draw(_ rect: CGRect) {
        self.layer.cornerRadius = self.bounds.height / 2
        self.layer.masksToBounds = true
        if isHighlighted {
            self.backgroundColor = .dustyOrange
        } else {
            self.layer.borderColor = UIColor.dustyOrange.cgColor
            self.layer.borderWidth = 1.5
        }
        //self.insetsLayoutMarginsFromSafeArea = true
    }
    
    func attributedString(from string: String, textColor: UIColor) -> NSAttributedString {
        let fontSize = UIFont.systemFontSize
        let attrs = [
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: fontSize),
            NSAttributedString.Key.foregroundColor: textColor
        ]
        return NSMutableAttributedString(string: string, attributes: attrs)
    }
}
