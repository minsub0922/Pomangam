//
//  OrderViewController.swift
//  PomangamiOS
//
//  Created by 최민섭 on 04/10/2019.
//  Copyright © 2019 최민섭. All rights reserved.
//

import UIKit

class DeliveryOrderViewController: UIViewController {
    
    var collectionView: UICollectionView {
        return UICollectionView(frame: .zero,
                                collectionViewLayout: UICollectionViewFlowLayout())
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.registerNib(PageChildCell.self)
        self.view.addSubview(collectionView)
        collectionView.addAutoLayout(parent: self.view)
    }
}

extension DeliveryOrderViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    enum CellType: Int {
        case menu = 0, options, request, amount
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "", for: indexPath) as? DeliveryOrderFooter, kind == UICollectionView.elementKindSectionFooter else {
            return UICollectionReusableView()
        }
        
        return footer
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let cellType = CellType(rawValue: section) else {
            return 0
        }
        switch cellType {
        case .menu:
            return 1
        case .options:
            return 2
        case .request:
            return 1
        case .amount:
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cellType = CellType(rawValue: indexPath.section) else {
            return UICollectionViewCell()
        }
        
        switch cellType {
        case .menu:
            let cell = collectionView.dequeueReusableCell(DeliveryOrderMenuCell.self, for: indexPath)
//            cell.setupView(model: )
            return cell
        case .options:
            let cell = collectionView.dequeueReusableCell(DeliveryOrderOptionCell.self, for: indexPath)
            return cell
        case .request:
            let cell = collectionView.dequeueReusableCell(DeliveryOrderRequestCell.self, for: indexPath)
            return cell
        case .amount:
            let cell = collectionView.dequeueReusableCell(DeliveryOrderOptionCell.self, for: indexPath)
            cell.isOptions = false
            return cell
        }
    }
}
