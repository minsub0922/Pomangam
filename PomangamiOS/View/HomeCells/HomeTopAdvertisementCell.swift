//
//  HomeTopAdvertisementCell.swift
//  PomangamiOS
//
//  Created by 최민섭 on 23/08/2019.
//  Copyright © 2019 최민섭. All rights reserved.
//

import UIKit

class HomeTopAdvertisementCell: UITableViewCell, CellProtocol {
    @IBOutlet weak var collectionView: UICollectionView!
    private var headerAdvertisements: [AdvertiseDto] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    func setupView(model: HomeTopAdvertisementCellViewModel) {
        self.headerAdvertisements = model.headerAdvertisements
    }
}

extension HomeTopAdvertisementCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return headerAdvertisements.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let model = headerAdvertisements[indexPath.row]
        let cell = collectionView.dequeueReusableCell(HomeTopAdvertisementChildCell.self, for: indexPath)
        cell.imageView.loadImageAsyc(url: API.baseURL + model.imagePath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        // 컬럼 여백
        return collectionView.frame.width / 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        //  행 하단 여백
        return collectionView.frame.width / 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = collectionView.frame.height * 0.75
        return CGSize(width: height, height: height)
    }
}
