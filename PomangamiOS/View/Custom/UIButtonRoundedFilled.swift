//
//  UIButtonRoundedFilled.swift
//  PomangamiOS
//
//  Created by 최민섭 on 2019/11/05.
//  Copyright © 2019 최민섭. All rights reserved.
//

import UIKit

class UIButtonRoundedFilled: UIButton {
    override var bounds: CGRect {
        didSet {
            self.layer.cornerRadius = self.bounds.height / 2
                self.layer.masksToBounds = true
        }
    }
    
    override func draw(_ rect: CGRect) {
        backgroundColor = .dustyOrange
               self.setAttributedTitle(
                   attributedString(
                       from: self.currentTitle ?? "",
                       textColor: .white ),
                       for: .normal)
               self.setAttributedTitle(
                   attributedString(
                       from: self.currentTitle ?? "",
                       textColor: UIColor.dustyOrange.withAlphaComponent(0.5)),
                   for: .focused)
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
