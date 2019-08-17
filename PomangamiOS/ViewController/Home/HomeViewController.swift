//
//  HomeViewController.swift
//  PomangamiOS
//
//  Created by 최민섭 on 08/08/2019.
//  Copyright © 2019 최민섭. All rights reserved.
//

import UIKit
import Alamofire

class HomeViewController: BaseRootViewController {

    @IBOutlet weak var menuCollectionView: UICollectionView!
    @IBOutlet weak var advertisementCollectionView: UICollectionView!
    private let homeMenuList = StaticLists.getHomeMenuList()
    private var headerAdvertisements: [AdvertiseDto] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        menuCollectionView.delegate = self
        menuCollectionView.dataSource = self
        advertisementCollectionView.delegate = self
        advertisementCollectionView.dataSource = self
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let params = [
            "deliverySiteIdx": 1
        ]
        APISource.shared.getMainall(params: params) { (res) in
            print(res)
            self.headerAdvertisements = res.advertiseForMainDtoList
            self.advertisementCollectionView.reloadSections(IndexSet(0...0))
        }
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case menuCollectionView:
            return homeMenuList.count
        case advertisementCollectionView:
            return headerAdvertisements.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case menuCollectionView:
            let menu = homeMenuList[indexPath.row]
            let cell = collectionView.dequeueReusableCell(HomeMenuCell.self, for: indexPath)
            cell.menuImageView.image = menu.image
            cell.menuLabel.text = menu.title
            return cell
        case advertisementCollectionView:
            let menu = headerAdvertisements[indexPath.row]
            let cell = collectionView.dequeueReusableCell(HeaderAdvertisementCell.self, for: indexPath)
            cell.imageView.loadImageAsyc(url: API.baseUrl + menu.imagePath)
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case menuCollectionView:
            let width = collectionView.frame.width * (1/3 - 1/10) - 1
            let height = collectionView.frame.height * 2/5
            return CGSize(width: width, height: width)
        case advertisementCollectionView:
            let height = collectionView.frame.height * 0.75
            return CGSize(width: height, height: height)
        default:
            return collectionView.contentSize
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        //  행 하단 여백
        switch collectionView {
        case menuCollectionView:
            return collectionView.frame.height * 1/7
        case advertisementCollectionView:
            return collectionView.frame.width / 20
        default:
            return CGFloat.leastNonzeroMagnitude
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        // 컬럼 여백
        switch collectionView {
        case menuCollectionView:
            return collectionView.frame.width / 10
        case advertisementCollectionView:
            return collectionView.frame.width / 10
        default:
            return CGFloat.leastNonzeroMagnitude
        }
    }
}

class HomeMenuCell: UICollectionViewCell {
    @IBOutlet weak var menuImageView: UIImageView!
    @IBOutlet weak var menuLabel: UILabel!
}

class HeaderAdvertisementCell: UICollectionViewCell {
    @IBOutlet weak var imageView: FasterImageView!
    override var bounds: CGRect {
        didSet {
            self.setupShadow()
        }
    }
    private func setupShadow() {
        self.layer.shadowOffset = CGSize(width: 0, height: 3)
        self.layer.shadowOpacity = 0.25
        self.layer.shadowRadius = 8.0
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: .allCorners, cornerRadii: CGSize(width: 3, height: 2)).cgPath
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
        self.layer.masksToBounds = false
    }
}
