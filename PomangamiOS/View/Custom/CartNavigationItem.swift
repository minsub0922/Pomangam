//
//  CartNavigationItem.swift
//  PomangamiOS
//
//  Created by 최민섭 on 2019/10/24.
//  Copyright © 2019 최민섭. All rights reserved.
//

import UIKit

class CartNavigationItem: UIView {
    var countLabel: UILabel = {
        var label: UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 10)
        label.backgroundColor = .clear
        label.textAlignment = .center
        label.text = " "
        label.textColor = .dustyOrange
        label.minimumScaleFactor = 0.2
        return label
    }()
    
    var imageView: UIImageView = {
        var imageView: UIImageView = UIImageView(image: UIImage(named: "btnDeliverymainBasket"))
        imageView.tintColor = .dustyOrange
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    var isEmpty = true
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(countLabel)
        addSubview(imageView)
        
        autolayout()
    }
    
    private func autolayout() {
        countLabel.frame = CGRect(x: 0, y: 0, width: 11, height: 11)
        countLabel.fontToFitHeight()
        countLabel.addAutoLayout(parent: self, heightRatio: 0.4, widthRatio: 0.4)
        countLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -1).isActive = true
        countLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: -1).isActive = true
        imageView.addAutoLayout(parent: self, heightRatio: 0.8)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func update() {
        if let res = RealmManger.getObjects(type: SingleOrder.self,
                                            byKeyPath: SingleOrder.primaryKey()) {
            self.isEmpty = res.count == 0
            self.countLabel.text = self.isEmpty ? " " : String(res.count)
            !self.isEmpty ? self.tick() : nil
        }
    }
}

class ReceiptNavigationItem: UIView {
    var imageView: UIImageView = {
        var imageView: UIImageView = UIImageView(image: UIImage(named: "btnDeliverymainOrderlist"))
        imageView.tintColor = .dustyOrange
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override init(frame: CGRect) {
         super.init(frame: frame)
         
         addSubview(imageView)
         
         autolayout()
     }
     
     private func autolayout() {
        imageView.frame = CGRect(x: 0, y: 15, width: 21, height: 21)
        imageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.6).isActive = true
        imageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
     }
     
     required init?(coder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }
}
