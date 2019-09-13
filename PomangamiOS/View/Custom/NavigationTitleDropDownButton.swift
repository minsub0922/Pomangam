//
//  File.swift
//  PomangamiOS
//
//  Created by 최민섭 on 26/08/2019.
//  Copyright © 2019 최민섭. All rights reserved.
//

import UIKit

class NavigationTitleDropDownButton: UIButton {
    
    /// Variable Declaration(s)
    var lblTitle: UILabel = {
        var lbl: UILabel = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.backgroundColor = .clear
        lbl.textAlignment = .center
        lbl.adjustsFontSizeToFitWidth = true
        lbl.minimumScaleFactor = 0.75
        lbl.textColor = .darkText
        lbl.font = .boldSystemFont(ofSize: UIFont.systemFontSize)
        return lbl
    }()
    
    var lblSubTitle: UILabel = {
        var lbl: UILabel = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.backgroundColor = .clear
        lbl.textAlignment = .center
        lbl.adjustsFontSizeToFitWidth = true
        lbl.minimumScaleFactor = 0.75
        lbl.textColor = .darkGray
        lbl.font = .systemFont(ofSize: UIFont.smallSystemFontSize)
        return lbl
    }()
    
    var imgVDropDown: UIImageView = {
        var imgV: UIImageView = UIImageView(image: UIImage(named: "btnDropDown")?.withRenderingMode(.alwaysTemplate))
        imgV.tintColor = .black
        return imgV
    }()
    
    fileprivate var verticalStackView: UIStackView = {
        let stackView: UIStackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.isUserInteractionEnabled = false
        stackView.alignment = .center
        stackView.axis = .vertical
        stackView.distribution = .equalCentering
        return stackView
    }()
    
    fileprivate var horizontalStackView: UIStackView = {
        let stackView: UIStackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.isUserInteractionEnabled = false
        stackView.alignment = .center
        stackView.axis = .horizontal
        stackView.distribution = .equalCentering
        stackView.spacing = 4
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        /// Preparing UIView
        prepareUIView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UI Related Method(s)
extension NavigationTitleDropDownButton {
    
    fileprivate func prepareUIView() {
        /// Adding SubView(s)
        addSubView()
        /// Preparing constraint(s)
        prepareConstraintForHorizontalStackView()
    }
    
    fileprivate func addSubView() {
        verticalStackView.addArrangedSubview(lblTitle)
        verticalStackView.addArrangedSubview(lblSubTitle)
        horizontalStackView.addArrangedSubview(verticalStackView)
        horizontalStackView.addArrangedSubview(imgVDropDown)
        addSubview(horizontalStackView)
    }
    
    fileprivate func prepareConstraintForHorizontalStackView() {
        horizontalStackView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        horizontalStackView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        horizontalStackView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1).isActive = true
        horizontalStackView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 1).isActive = true
    }
    
    fileprivate func handleSubViewAlpha(_ value: CGFloat) {
        [lblTitle, lblSubTitle, imgVDropDown].forEach { (obj) in
            obj.alpha = value
        }
    }
}

// MARK: - Configuartion Related Method(s)
extension NavigationTitleDropDownButton {
    
    func configure(_ title: String, subTitle: String? = nil) {
        lblTitle.text = title
        lblSubTitle.text = subTitle
        lblSubTitle.isHidden = (subTitle?.isEmpty == true)
    }
}

// MARK: - UI Touches Related Method(s)
extension NavigationTitleDropDownButton {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        handleSubViewAlpha(0.5)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        handleSubViewAlpha(1.0)
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        handleSubViewAlpha(1.0)
    }
}
