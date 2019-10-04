//
//  DeliveryHeaderAdvertisementCell.swift
//  PomangamiOS
//
//  Created by 최민섭 on 24/09/2019.
//  Copyright © 2019 최민섭. All rights reserved.
//

import UIKit

class DeliveryHeaderAdvertisementCell: UICollectionViewCell, CellProtocol {
    var ads: [AdvertiseDto] = []
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.contentInset = .init(top: 0, left: 25, bottom: 0, right: 0)
        collectionView.registerNib(DeliveryHeaderAdvertisementChildCell.self)
    }

    func setupView(model: DeliveryHeaderAdvertisementCellViewModel) {
        ads = model.headerAdvertisements
        collectionView.reloadSection(section: 0)
    }
}

extension DeliveryHeaderAdvertisementCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return collectionView.bounds.width / 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = collectionView.bounds.height * 0.85
        let width = collectionView.bounds.width * 0.75
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ads.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(DeliveryHeaderAdvertisementChildCell.self, for: indexPath)
        let ad = ads[indexPath.row]
        cell.imageView.loadImageAsyc(fromURL: ad.imagePath)
        return cell
    }
    
    
}
