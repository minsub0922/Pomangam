//
//  HomeViewController.swift
//  PomangamiOS
//
//  Created by 최민섭 on 08/08/2019.
//  Copyright © 2019 최민섭. All rights reserved.
//

import UIKit
import Alamofire

public protocol DeliveryViewControllerDelegate: class {
    func navigateToMenuList<T>(packet: T?)
}

class DeliveryViewController: BaseViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    public weak var delegate: DeliveryViewControllerDelegate?
    private let customCartButton = CartNavigationItem()
    private var headerAdvertisements: [AdvertiseDto] = []
    private var markets: [DeliveryMarket] = []
    private var homeHeaderAdCellViewModel: DeliveryHeaderAdvertisementCellViewModel {
        return DeliveryHeaderAdvertisementCellViewModel(headerAdvertisements: headerAdvertisements)
    }

    //MARK:- View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBarButtons()
        
        if let navigationController = navigationController {
            DeliveryCommon.shared.navigationController = navigationController
        }
    
        setupCollectionView()
        getMainDatas()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        customCartButton.bounce()
    }

    //MARK:- Server API
    private func getMainDatas() {
        let params = [ "deliverySiteIdx": 1 ]
        APISource.shared.getMainall(params: params) { res in
            self.headerAdvertisements = res.advertiseForMainDtoList
            self.collectionView.reloadSection(section: CellType.headerAd.rawValue)
            
            //Test
            let arrivalDate = "\(Date().tomorrow.toNormalFormat) 19:00:00"
            APISource.shared.getDeliveryMarkets(arrivalDate: arrivalDate, detailForDeliverySiteIndex: "1") { (res) in
                self.markets = res
                self.collectionView.reloadSection(section: CellType.market.rawValue)
            }
        }
    }
    
    //MARK:- Setup Views
    private func setupCollectionView() {
        collectionView.contentInset = .init(top: 0, left: 0, bottom: 0, right: 0)
        collectionView.registerNib(DeliveryHeaderAdvertisementCell.self)
        collectionView.registerNib(DeliveryArrivalCell.self)
        collectionView.registerNib(DeliveryMarketCell.self)
    }
    
    private func setupNavigationBarButtons() {
        let navigationButtonView = NavigationTitleDropDownButton()
        navigationButtonView.configure("한국항공대학교")
        let navigationReceiptButton = UIBarButtonItem(image: UIImage(named: "btnDeliverymainOrderlist"),
                                                      style: .plain,
                                                      target: self,
                                                      action: #selector(navigationReceiptButtonTapAction(_:)))
        navigationReceiptButton.customView = ReceiptNavigationItem()
        let navigationCartButton = UIBarButtonItem(title: "한국항공대학교",
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(navigationTitleTapAction(_:)))
        
        navigationCartButton.customView = customCartButton
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "한국항공대학교",
                                                           style: .plain,
                                                           target: self,
                                                           action: #selector(navigationTitleTapAction(_:)))
        
        navigationItem.leftBarButtonItem?.customView = navigationButtonView
        
        navigationItem.rightBarButtonItems = [navigationCartButton, navigationReceiptButton]
        
    }
    
    @objc private func navigationReceiptButtonTapAction(_ sender: UIBarButtonItem) {
        
    }
    
    @objc private func navigationCartButtonTapAction(_ sender: UIBarButtonItem) {
        DeliveryCommon.shared.navigationController?.pushViewController(storyboard: "Delivery", viewController: DeliveryCartViewController.self)
    }
    
    @objc private func navigationTitleTapAction(_ sender: UIBarButtonItem) {
        print("cleicked??")
    }
}

extension DeliveryViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    /**
     Delivery 컬렉션 뷰의 타입
     
     - headerAd: 상단 배너
     - arrivalSpot: 도착 장소 및 시간
     - market: 매장들
     */
    enum CellType: Int {
        case headerAd = 0, arrivalSpot, market
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let cellType = CellType(rawValue: section) else {return 0}
        switch cellType {
        case .headerAd, .arrivalSpot:
            return 1//fix
        case .market:
            return markets.count;
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cellType = CellType(rawValue: indexPath.section) else {return}
        switch cellType {
        case .headerAd, .arrivalSpot:
            break
        case .market:
            navigationController?.pushViewController(storyboard: "Delivery", viewController: DeliveryMenuListViewController.self, packet: markets[indexPath.row])
            break
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        guard let cellType = CellType(rawValue: section) else {return .leastNonzeroMagnitude}
        switch cellType {
        case .market:
            return 1
        default:
            return .leastNonzeroMagnitude
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let cellType = CellType(rawValue: indexPath.section) else {return .zero}
        let fullHeight = collectionView.bounds.height;
        let fullWidth = collectionView.bounds.width;
        
        switch cellType {
        case .headerAd:
            return CGSize(width: fullWidth, height: fullHeight * 0.35)
        case .arrivalSpot:
            return CGSize(width: fullWidth, height: fullHeight * 0.1)
        case .market:
            return CGSize(width: collectionView.bounds.width/3-1, height: fullHeight * 0.22)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cellType = CellType(rawValue: indexPath.section) else {return  UICollectionViewCell() }
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
            cell.setupView(model: markets[indexPath.row].asDeliveryMarketViewModel)
            return cell;
        }
    }
}
