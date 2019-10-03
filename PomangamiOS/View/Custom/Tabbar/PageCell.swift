//
//  PageCell.swift
//  PomangamiOS
//
//  Created by 최민섭 on 03/10/2019.
//  Copyright © 2019 최민섭. All rights reserved.
//

import UIKit

class PageCell: UICollectionViewCell {
    var collectionView: UICollectionView = {
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 100, height: 100), collectionViewLayout: collectionViewLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.backgroundColor = .gray
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .gray
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.registerNib(MarketMenuCell.self)
        self.addSubview(collectionView)
        collectionView.frame = self.frame
    }
}

extension PageCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width / 2 - 5, height: collectionView.bounds.width / 2 - 1)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MarketMenuCell.reusableIdentifier, for: indexPath) as! MarketMenuCell
        return cell
    }
    
    
}
