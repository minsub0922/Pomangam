//
//  HomeViewController.swift
//  PomangamiOS
//
//  Created by 최민섭 on 08/08/2019.
//  Copyright © 2019 최민섭. All rights reserved.
//

import UIKit
import Alamofire

class DeliveryViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    private var headerAdvertisements: [AdvertiseDto] = []
    private var markets: [Market] = []
    private var navigationButtonView: NavigationTitleDropDownButton = NavigationTitleDropDownButton()
    private var homeHeaderAdCellViewModel: DeliveryHeaderAdvertisementCellViewModel {
        return DeliveryHeaderAdvertisementCellViewModel(headerAdvertisements: headerAdvertisements)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBarButtons()
    
        collectionView.contentInset = .init(top: 0, left: 0, bottom: 0, right: 0)
        collectionView.registerNib(DeliveryHeaderAdvertisementCell.self)
        collectionView.registerNib(DeliveryArrivalCell.self)
        collectionView.registerNib(DeliveryMarketCell.self)
    }
    
    
    private func setupNavigationBarButtons() {
        navigationButtonView.configure("한국항공대학교")
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "한국항공대학교", style: .plain, target: self, action: #selector(navigationTitleTapAction(_:)))
        navigationItem.leftBarButtonItem?.customView = navigationButtonView
        
        let navigationReceiptButton = UIBarButtonItem(image: UIImage(named: "btnDeliverymainOrderlist"), style: .plain, target: self, action: nil)
        let navigationCartButton = UIBarButtonItem(image: UIImage(named: "btnDeliverymainBasket"), style: .plain, target: self, action: nil)
        navigationItem.rightBarButtonItems = [navigationCartButton, navigationReceiptButton]
        
    }
    
    @objc private func navigationTitleTapAction(_ sender: Any) {
        print("cleicked??")
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        APISource.shared.getTokenGuest { res in
            UserDefaults.standard.setCustomObject(object: res, key: .accessToken)
            
            let params = [ "deliverySiteIdx": 1 ]
            APISource.shared.getMainall(params: params) { res in
                //print(res)
                self.headerAdvertisements = res.advertiseForMainDtoList
                self.collectionView.reloadSection(section: DeliveryCellType.headerAd.rawValue)
            }
        }
        
        APISource.shared.getMarkets(deliverySiteIndex: "1", type: .affiliate) { (res) in
            print(res)
            self.markets = res
            self.collectionView.reloadSection(section: DeliveryCellType.market.rawValue)
            
        }
    }
}

/**
 Delivery 컬렉션 뷰의 타입
 
 - headerAd: 상단 배너
 - arrivalSpot: 도착 장소 및 시간
 - market: 매장들
 */
enum DeliveryCellType: Int {
    case headerAd = 0, arrivalSpot, market
}

extension DeliveryViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let cellType = DeliveryCellType(rawValue: section) else {return 0}
        switch cellType {
        case .headerAd, .arrivalSpot:
            return 1//fix
        case .market:
            return markets.count;
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        guard let cellType = DeliveryCellType(rawValue: section) else {return .zero}
        switch cellType {
        case .market:
            return self.collectionView.bounds.width/50
        default:
            return .zero
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let cellType = DeliveryCellType(rawValue: indexPath.section) else {return .zero}
        let fullHeight = collectionView.bounds.height;
        let fullWidth = collectionView.bounds.width;
        
        switch cellType {
        case .headerAd:
            return CGSize(width: fullWidth, height: fullHeight * 0.3)
        case .arrivalSpot:
            return CGSize(width: fullWidth, height: fullHeight * 0.06)
        case .market:
            return CGSize(width: collectionView.bounds.width/5-1, height: fullHeight * 0.15)
        default:
            return .zero
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cellType = DeliveryCellType(rawValue: indexPath.section) else {return  UICollectionViewCell() }
        switch cellType {
        case .headerAd:
            let cell = collectionView.dequeueReusableCell(DeliveryHeaderAdvertisementCell.self, for: indexPath)
            cell.setupView(model: homeHeaderAdCellViewModel)
            return cell;
        case .arrivalSpot:
            let cell = collectionView.dequeueReusableCell(DeliveryArrivalCell.self, for: indexPath)
            return cell
        case .market:
            let cell = collectionView.dequeueReusableCell(DeliveryMarketCell.self, for: indexPath)
            cell.setupView(model: markets[indexPath.row].asMarketViewModel)
            return cell;
        default:
            break;
        }
        
        return UICollectionViewCell()
    }
}
