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
    
}

class ArrivalPlaceViewController: BaseViewController {
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var tableView: UITableView!
    private var selectedPin:MKPlacemark? = nil
    private var selectedLoc: MKAnnotation?
    private lazy var locationManager: CLLocationManager = {
        let locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        return locationManager
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
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
    //controll MapPin
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView?{
        if annotation is MKUserLocation {
            //return nil so map view draws "blue dot" for standard user location
            return nil
        }
        
        self.selectedLoc = annotation
        let actionButton = UIButton(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: 30, height: 30)))
        actionButton.addTarget(self, action: #selector(addLocationToList), for: .touchUpInside)
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier:
            "pin") as? MKPinAnnotationView
        pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "pin")
        pinView?.pinTintColor = UIColor.orange
        pinView?.canShowCallout = true
        pinView?.rightCalloutAccessoryView = actionButton
        return pinView
    }
    
    @objc func addLocationToList(){
        
    }
}

