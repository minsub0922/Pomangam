//
//  HomeMenuCell.swift
//  PomangamiOS
//
//  Created by 최민섭 on 23/08/2019.
//  Copyright © 2019 최민섭. All rights reserved.
//

import UIKit

class HomeMenuCell: UITableViewCell, CellProtocol {
    @IBOutlet weak var collectionView: UICollectionView!
    private var menuList: [HomeMenuModel] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.registerNib(HomeMenuChildCell.self)
    }
    
    func setupView(model: HomeMenuCellViewModel) {
        self.menuList = model.menuList
        self.collectionView.reloadData()
    }
}

extension HomeMenuCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        // 컬럼 여백
        //return CGFloat.leastNonzeroMagnitude
        return self.collectionView.bounds.width/50
    }
    
    //셀 사이즈
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.collectionView.bounds.width/5-1, height: self.collectionView.bounds.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menuList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let model = menuList[indexPath.row]
        let cell = collectionView.dequeueReusableCell(HomeMenuChildCell.self, for: indexPath)
        cell.imageView.image = model.image
        cell.titleLabel.text = model.title
        return cell
    }
}
