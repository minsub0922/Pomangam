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

    @IBOutlet weak var collectionView: UICollectionView!
    private let homeMenuList = FinalLists.getHomeMenuList()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let params = [
            "deliverySiteIdx": 1
        ]
        APISource.shared.getListallMain(params: params) { (res) in
            print(res)
        }
//        
//        Alamofire.request("https://www.pomangam.com:9530/api/v1/views/main", method: .get, parameters: params, headers: ["Authorization": "Bearer 7e67d67d-df31-4373-b6dc-1a60d2cbce7f"])
//            .responseJSON(completionHandler: { (res) in
//                print(res.description)
//            })
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return homeMenuList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let menu = homeMenuList[indexPath.row]
        
        let cell = collectionView.dequeueReusableCell(HomeMenuCell.self, for: indexPath)
        cell.menuImageView.image = menu.image
        cell.menuLabel.text = menu.title
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = collectionView.frame.width * (1/3 - 1/10) - 1
        let height = collectionView.frame.height * 2/5
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        //  행 하단 여백
        return collectionView.frame.height * 1/7
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        // 컬럼 여백
        return collectionView.frame.width / 10
    }
    
    
}
