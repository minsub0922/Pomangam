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
    }
    
    func setupView(model: HomeMenuCellViewModel) {
        
    }
}

extension HomeMenuCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menuList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let model = menuList[indexPath.row]
        let cell = collectionView.dequeueReusableCell(HomeMenuChildCell.self, for: indexPath)
        
        return cell
    }
    
    
}
