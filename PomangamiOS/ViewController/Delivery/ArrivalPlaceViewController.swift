//
//  ArrivalPlaceViewController.swift
//  PomangamiOS
//
//  Created by 최민섭 on 2019/10/26.
//  Copyright © 2019 최민섭. All rights reserved.
//

import UIKit
import MapKit

protocol ArrivalPlaceViewControllerDelegate {
    func popToDeliveryMain(changedInstance: ArrivalPlaceResponse)
}

class ArrivalPlaceViewController: BaseViewController {
    fileprivate var selectedPin:MKPlacemark? = nil
    fileprivate var selectedLoc: MKAnnotation?
    fileprivate var places: [ArrivalPlaceResponse] = []
    fileprivate lazy var locationManager: CLLocationManager = {
        let locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        return locationManager
    }()
    fileprivate var selectedLocation: ArrivalPlaceResponse?
    public var deliverySiteIndex: Int!
    public var delegate: ArrivalPlaceViewControllerDelegate?
    
    @IBOutlet weak var mapView: MKMapView! {
        didSet {
            mapView.mapType = MKMapType.standard
        }
    }
    @IBOutlet weak var tableView: UITableView!
    @IBAction func touchupAppleButton(_ sender: Any) {
        if let selectedLocation = selectedLocation {
            delegate?.popToDeliveryMain(changedInstance: selectedLocation)
        } else {
            dismiss(animated: true, completion: nil)
        }
    }
    
    //MARK:- View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
        getDeliveryArrivalPlaces()
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func getDeliveryArrivalPlaces() {
        APISource.shared.getDeliveryArrivalPlaces(deliverySiteIdx: deliverySiteIndex) { res in
            self.places = res
            self.setupMarkers()
            self.tableView.reloadSection(section: 0) {
                DispatchQueue.main.async {
                    self.tableView.selectRow(at: IndexPath.init(row: 0, section: 0), animated: true, scrollPosition: .none)
                }
            }
        }
    }
    
    private func setupMarkers() {
        zoomTo(location: places[0].asCLLocation)
        for place in places {
            self.mapView.addAnnotation(place.asAnnotation)
        }
    }
}

extension ArrivalPlaceViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.requestLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
            let region = MKCoordinateRegion(center: location.coordinate, span: span)
            mapView.setRegion(region, animated: true)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}


extension ArrivalPlaceViewController : MKMapViewDelegate {
    //MARK: Controll MapPin
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView?{
        if annotation is MKUserLocation {
            //return nil so map view draws "blue dot" for standard user location
            return nil
        }
        
        self.selectedLoc = annotation
        let actionButton = UIButton(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: 30, height: 30)))
        actionButton.addTarget(self, action: #selector(touchupMarker), for: .touchUpInside)
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier:
            "pin") as? MKPinAnnotationView
        pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "pin")
        pinView?.pinTintColor = UIColor.orange
        pinView?.canShowCallout = true
        pinView?.rightCalloutAccessoryView = actionButton
        return pinView
    }
    
    @objc private func touchupMarker(){
        
    }
    
    fileprivate func zoomTo(location: CLLocationCoordinate2D) {
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let region = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: true)
    }
}

//MARK: - UITalbeVewDelegate
extension ArrivalPlaceViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let targetPlace = places[indexPath.row]
        zoomTo(location: targetPlace.asCLLocation)
        selectedLocation = targetPlace
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return places.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let place = places[indexPath.row]
        let cell: ArrivalPlaceCell = tableView.dequeueReusableCell(withIdentifier: "ArrivalPlaceCell", for: indexPath) as! ArrivalPlaceCell
        
        cell.placeImageView.image = UIImage(named: "btnDeliveryplacePlaceAOn")
        cell.locationLabel.text = place.name
        if Int(place.asArrivalTimeToMinute) == 0 {
            cell.arrivalTimeLabel.text = "정각 도착"
        } else {
            cell.arrivalTimeLabel.text = "도착시간 + \(place.asArrivalTimeToMinute)분"
        }
        
        return cell
    }
}

class ArrivalPlaceCell: UITableViewCell {
    @IBOutlet weak var placeImageView: UIImageView!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var arrivalTimeLabel: UILabel!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.dustyOrange.withAlphaComponent(0.05)
        self.selectedBackgroundView = backgroundView
    }
}
