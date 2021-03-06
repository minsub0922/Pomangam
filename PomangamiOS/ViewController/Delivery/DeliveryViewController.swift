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
    func presentArrivalPlace<T>(packet: T?)
    func presentArrivalTime<T>(packet: T?)
}

class DeliveryViewController: DeliveryBaseViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    public weak var delegate: DeliveryViewControllerDelegate?
    private var headerAdvertisements: [AdvertiseDto] = []
    private var markets: [DeliveryMarket] = []
    private var deliverySiteIndex = 1
    private var homeHeaderAdCellViewModel: DeliveryHeaderAdvertisementCellViewModel {
        return DeliveryHeaderAdvertisementCellViewModel(headerAdvertisements: headerAdvertisements)
    }
    
    private var arrivalInfos: (String, String) = (String(), String()) {
        didSet {
            self.collectionView.reloadSection(section: CellType.arrivalSpot.rawValue)
        }
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

    // MARK:- Server API
    private func getMainDatas() {
        APISource.shared.getMainall(deliverySiteIdx: self.deliverySiteIndex) { res in
            self.headerAdvertisements = res.advertiseForMainDtoList
            self.collectionView.reloadSection(section: CellType.headerAd.rawValue)
            self.getMarketDatas()
        }
    }
    
    private func getMarketDatas() {
        // TODO: need real data for time
        let arrivalDate = "\(Date().tomorrow.toNormalFormat) 19:00:00"
        let asyncGroup = DispatchGroup()
        let asyncQueue = DispatchQueue.global()
        var dictionary: [Int:MarketDetailResponse] = [:]
        
        asyncGroup.enter()
        APISource.shared.getDeliveryMarkets(arrivalDate: arrivalDate,
                                            detailForDeliverySiteIndex: self.deliverySiteIndex) { markets in
            self.markets = markets
            for market in markets {
                asyncGroup.enter()
                asyncQueue.async {
                    APISource.shared.getMarketDetail(storeIndex: market.index) { res in
                        dictionary[res.index] = res
                        asyncGroup.leave()
                    }
                }
            }
            asyncGroup.leave()
        }
        
        asyncGroup.notify(queue: asyncQueue) {
            for i in 0..<self.markets.count {
                if let market = dictionary[self.markets[i].index] {
                    self.markets[i].setDetailSummary(rating: market.starRating, commentCount: market.commentCounts)
                }
            }
            
            self.collectionView.reloadSection(section: CellType.market.rawValue)
            self.getArrivalInfos()
        }
    }
    
    private func getArrivalInfos() {
        guard let arrivalPlace: ArrivalPlaceResponse = UserDefaults.standard.getCustomObject(key: .arrivalPlace) else {
            self.getDeliveryArrivalPlaces()
            return
        }
        
        APISource.shared.getDeliveryArrivalTimes(deliverySiteIdx: deliverySiteIndex) { res in
            let arrivalTime = res.hours.filter { $0.hour ?? 0 > 1 } [0].hour ?? res.hours.last?.hour ?? 0
            let arrivalTimeInfo = SelectedArrivalTime(hour: arrivalTime)
            
            UserDefaults.standard.setCustomObject(object: arrivalTimeInfo,
                                                  key: .arrivalTime)
            self.arrivalInfos = (arrivalPlace.name, "\(arrivalTime)시")
        }
    }
    
    private func getDeliveryArrivalPlaces() {
       APISource.shared.getDeliveryArrivalPlaces(deliverySiteIdx: deliverySiteIndex) { res in
        UserDefaults.standard.setCustomObject(object: res[0], key: .arrivalPlace)
        UserDefaults.standard.setCustomObject(object: SelectedArrivalTime(hour: 17), key: .arrivalTime)
        self.arrivalInfos = (res[0].name, "17시")
       }
    }
    
    // MARK:- Setup Views
    private func setupCollectionView() {
        collectionView.contentInset = .init(top: 0, left: 0, bottom: 0, right: 0)
        collectionView.registerNib(DeliveryHeaderAdvertisementCell.self)
        collectionView.registerNib(DeliveryArrivalCell.self)
        collectionView.registerNib(DeliveryMarketCell.self)
    }
    
    private func setupNavigationBarButtons() {
        let navigationButtonView = NavigationTitleDropDownButton(title: "한국항공대학교")
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "",
                                                           style: .plain,
                                                           target: self,
                                                           action: #selector(navigationTitleTapAction(_:)))
        navigationItem.leftBarButtonItem?.customView = navigationButtonView
        setupReceiptCartNavigationbarButton()
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
        return 3
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
            cell.delegate = self
            cell.setupView(model: DeliveryArrivalCellViewModel(location: arrivalInfos.0,
                                                               arrivalTime: arrivalInfos.1))
            return cell
        case .market:
            let cell = collectionView.dequeueReusableCell(DeliveryMarketCell.self, for: indexPath)
            cell.setupView(model: markets[indexPath.row].asDeliveryMarketViewModel)
            return cell;
        }
    }
}

extension DeliveryViewController: DeliveryArrivalCellProtocol {
    func tapTimeButton() {
        delegate?.presentArrivalTime(packet: self.deliverySiteIndex)
    }
    
    func tapLocationButton() {
        delegate?.presentArrivalPlace(packet: self.deliverySiteIndex)
    }
}

extension DeliveryViewController: DeliveryArrivalDelegate {
    func timeDidChange(changedInstance: SelectedArrivalTime) {
        self.arrivalInfos = (self.arrivalInfos.0, "\(changedInstance.hour)시")
    }
    
    func placeDidChange(changedInstance: ArrivalPlaceResponse) {
        self.arrivalInfos = (changedInstance.name, self.arrivalInfos.1)
    }
}
