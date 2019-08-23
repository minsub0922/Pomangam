//
//  HomeHeaderAdvertisementCell.swift
//  PomangamiOS
//
//  Created by 최민섭 on 23/08/2019.
//  Copyright © 2019 최민섭. All rights reserved.
//

import UIKit

class HomeHeaderAdvertisementCell: UITableViewCell, CellProtocol {
    @IBOutlet weak var collectionView: UICollectionView!
    private var headerAdvertisements: [AdvertiseDto] = []

    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.contentInset = .init(top: 0, left: 25, bottom: 0, right: 0)
        collectionView.registerNib(HomeHeaderAdvertisementChildCell.self)
    }
    
    func setupView(model: HomeHeaderAdvertisementCellViewModel) {
        self.headerAdvertisements = model.headerAdvertisements
        self.collectionView.reloadData()
    }
}

extension HomeHeaderAdvertisementCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return collectionView.bounds.width / 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = collectionView.bounds.height * 0.88
        return CGSize(width: height, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return headerAdvertisements.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let model = headerAdvertisements[indexPath.row]
        let cell = collectionView.dequeueReusableCell(HomeHeaderAdvertisementChildCell.self, for: indexPath)
        cell.imageView.loadImageAsyc(url: API.baseURL + model.imagePath)
        return cell
    }
    
    
}
