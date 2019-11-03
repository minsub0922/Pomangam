//
//  ArrivalTimeViewController.swift
//  PomangamiOS
//
//  Created by 최민섭 on 2019/10/27.
//  Copyright © 2019 최민섭. All rights reserved.
//

import UIKit

protocol ArrivalTimeViewControllerDelegate {
    func popToDEliveryMain(changedInstance: String)
}

class ArrivalTimeViewController: BaseViewController {
    fileprivate var availableTimes: [String] = []
    fileprivate var selectedHour: String = String()
    public var deliverySiteIndex: Int!
    public var delegate: ArrivalTimeViewControllerDelegate?
    
    @IBAction func touchupApplyButton(_ sender: Any) {
    }
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var timeStateLabel: UILabel!
    @IBOutlet weak var deliveryStateLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    
    @IBAction func touchupApplyArrivalTimeButton(_ sender: Any) {
        delegate?.popToDEliveryMain(changedInstance: selectedHour)
    }
    
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
                        self.availableTimes.append("\(hour)시 \(String(format: "%02d", minute))분")
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
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return availableTimes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ArrivalTimeCell.className, for: indexPath) as? ArrivalTimeCell else {
            return UITableViewCell()
        }
        cell.arrivalTimeLabel.text = availableTimes[indexPath.row]
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
