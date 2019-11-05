//
//  UIButtonSelectorRounded.swift
//  PomangamiOS
//
//  Created by 최민섭 on 23/08/2019.
//  Copyright © 2019 최민섭. All rights reserved.
//

import UIKit
enum UIButtonSelectorType {
    case filled
    case stroke
}

class UIButtonSelectorRounded: UIButton {
    override var isHighlighted: Bool {
        didSet {
            self.setupButtonView()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setAttributedTitle(
            attributedString(
                from: self.currentTitle ?? "",
                textColor: .dustyOrange ),
                for: .highlighted)
        self.setAttributedTitle(
            attributedString(
                from: self.currentTitle ?? "",
                textColor: .lightGray),
                for: .normal)
        self.layer.borderWidth = 1.5
    }
    
    private func setupButtonView() {
        if isHighlighted {
            self.layer.borderColor = UIColor.dustyOrange.cgColor
        } else {
            self.layer.borderColor = UIColor.lightGray.cgColor
        }
    }
    
    override func draw(_ rect: CGRect) {
        self.layer.cornerRadius = self.bounds.height / 2
        self.layer.masksToBounds = true
        self.setupButtonView()
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
