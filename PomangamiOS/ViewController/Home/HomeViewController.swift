//
//  HomeViewController.swift
//  PomangamiOS
//
//  Created by 최민섭 on 08/08/2019.
//  Copyright © 2019 최민섭. All rights reserved.
//

import UIKit
import Alamofire

enum HomeCellType {
    case topAd
    case search
    case menu
    case community
}

class HomeViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    private var headerAdvertisements: [AdvertiseDto] = []
    private var navigationButtonView: NavigationTitleDropDownButton = NavigationTitleDropDownButton()
    private var homeHeaderAdCellViewModel: HomeHeaderAdvertisementCellViewModel {
        return HomeHeaderAdvertisementCellViewModel(headerAdvertisements: headerAdvertisements)
    }
    private let homeMenuCellViewModel: HomeMenuCellViewModel = {
        return HomeMenuCellViewModel(menuList: StaticLists.getHomeMenuList())
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBarButtons()
    
        tableView.contentInset = .init(top: UIScreen.main.bounds.size.height * 0.03, left: 0, bottom: 0, right: 0)
        tableView.registerNib(HomeHeaderAdvertisementCell.self)
        tableView.registerNib(HomeSearchTableViewCell.self)
        tableView.registerNib(HomeMenuCell.self)
        tableView.registerNib(HomeCommunityCell.self)
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
                print(res)
                self.headerAdvertisements = res.advertiseForMainDtoList
                self.tableView.reloadData()
            }
        }
        
        APISource.shared.getDeliverySite(deliverySiteIndex: "1", type: .affiliate) { (res) in
            print(res)
        }
    }
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0,1,2:
            return 1//fix
        case 3:
            return 1//community count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return UIScreen.main.bounds.size.height * 0.2
        case 1:
            return UIScreen.main.bounds.size.height * 0.06
        case 2:
            return UIScreen.main.bounds.size.height * 0.15
        case 3:
            return 30 * 1 //community count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(HomeHeaderAdvertisementCell.self, for: indexPath)
            cell.setupView(model: homeHeaderAdCellViewModel)
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(HomeSearchTableViewCell.self, for: indexPath)
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(HomeMenuCell.self, for: indexPath)
            cell.setupView(model: homeMenuCellViewModel)
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(HomeCommunityCell.self, for: indexPath)
            return cell
        default:
            break
        }
        
        return UITableViewCell()
    }
}
