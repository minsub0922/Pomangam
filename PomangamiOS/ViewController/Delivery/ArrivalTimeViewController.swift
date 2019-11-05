//
//  ArrivalTimeViewController.swift
//  PomangamiOS
//
//  Created by 최민섭 on 2019/10/27.
//  Copyright © 2019 최민섭. All rights reserved.
//

import UIKit

protocol ArrivalTimeViewControllerDelegate {
    func popToDeliveryMain(changedInstance: SelectedArrivalTime?)
}

class ArrivalTimeViewController: BaseViewController {
    fileprivate var availableTimes: [SelectedArrivalTime] = []
    fileprivate var selectedTime: SelectedArrivalTime?
    public var deliverySiteIndex: Int!
    public var delegate: ArrivalTimeViewControllerDelegate?
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var locationLabel: UILabel! {
        didSet {
            guard let place: ArrivalPlaceResponse = UserDefaults.standard.getCustomObject(key: .arrivalPlace) else {
                return
            }
            
            locationLabel.text = place.name
        }
    }
    @IBOutlet weak var timeLabel: UILabel! {
        didSet {
            guard let time: SelectedArrivalTime = UserDefaults.standard.getCustomObject(key: .arrivalTime) else {
                return
            }
            timeLabel.text = "\(time.hour)시 \(String(format: "%02d", time.minute))분"
        }
    }
    @IBOutlet weak var timeStateLabel: UILabel! {
        didSet {
            timeStateLabel.text = "PM"
        }
    }
    @IBOutlet weak var deliveryStateLabel: UILabel! {
        didSet {
            deliveryStateLabel.text = "도착예정"
        }
    }
    
    
    @IBAction func touchupApplyArrivalTimeButton(_ sender: Any) {
        delegate?.popToDeliveryMain(changedInstance: selectedTime)
    }
    
    // MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        getHours()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        containerView.setupShadow()
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func getHours() {
        APISource.shared.getDeliveryArrivalTimes(deliverySiteIdx: deliverySiteIndex) { res in
            for hour in res.hours {
                if let minutes = hour.minutes, let hour = hour.hour {
                    for minute in minutes {
                        self.availableTimes.append(SelectedArrivalTime(hour: hour, minute: minute))
                    }
                }
            }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}

extension ArrivalTimeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedTime = availableTimes[indexPath.row]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return availableTimes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ArrivalTimeCell.className, for: indexPath) as? ArrivalTimeCell else {
            return UITableViewCell()
        }
        let time = availableTimes[indexPath.row]
        cell.arrivalTimeLabel.text = "\(time.hour)시 \(String(format: "%02d", time.minute))분"
        return cell
    }
}

class ArrivalTimeCell: UITableViewCell {
    @IBOutlet weak var arrivalTimeLabel: UILabel!
    required init?(coder: NSCoder) {
       super.init(coder: coder)
       
       let backgroundView = UIView()
       backgroundView.backgroundColor = UIColor.dustyOrange.withAlphaComponent(0.05)
       self.selectedBackgroundView = backgroundView
   }
}
