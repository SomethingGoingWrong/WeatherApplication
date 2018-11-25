//
//  MapViewController.swift
//  WeatherApp
//
//  Created by Назар on 11/23/18.
//  Copyright © 2018 Nazar Voytovich. All rights reserved.
//

import Foundation
import UIKit
import GoogleMaps
import CoreLocation
import MapKit

class MapViewController: UIViewController, GMSMapViewDelegate{
  var presenter: MapViewToPresenterProtocol?
  let locationManager = CLLocationManager()
  @IBOutlet weak var map: MKMapView!
  @IBOutlet weak var confirmButton: UIButton!
  @IBAction func locationConfirmed(_ sender: Any) {
    presenter?.showWeather(forCoordinates: map.userLocation.coordinate)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupLocationManager()
    confirmButton.layer.cornerRadius = 10
  }
  
  func setupLocationManager(){
    if CLLocationManager.locationServicesEnabled() {
      locationManager.delegate = self
      locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
      locationManager.startUpdatingLocation()
    }else{
      let alert = UIAlertController(title: "Alert", message: "App dont allowed to get your position!", preferredStyle: UIAlertController.Style.alert)
      alert.addAction(UIAlertAction(title: "Return", style: UIAlertAction.Style.default, handler: {(action:UIAlertAction!) in
        self.dismiss(animated: true, completion: nil)}))
      self.present(alert, animated: true, completion: nil)
    }
    }
  }

extension MapViewController: MapPresenterToViewProtocol{

}

extension MapViewController: CLLocationManagerDelegate{
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    if manager.location?.coordinate != nil{
      let userLocation:CLLocation = locations.last!
      let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
      let regionView = MKCoordinateRegion(center: userLocation.coordinate, latitudinalMeters: 1500, longitudinalMeters: 1500)
      self.map.setRegion(regionView, animated: true)
      self.map.showsUserLocation = true
      //mapView.animate(with: camera)
      
  }
}
}
