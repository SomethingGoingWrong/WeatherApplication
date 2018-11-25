//
//  MapViewPresenter.swift
//  WeatherApp
//
//  Created by Назар on 11/23/18.
//  Copyright © 2018 Nazar Voytovich. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

class MapViewPresenter: MapViewToPresenterProtocol{
  var view: MapPresenterToViewProtocol?
  var interactor: MapPresenterToInteractorProtocol?
  var router: MapPresenterToRouterProtocol?
  
  func showWeather(forCoordinates coordinates: CLLocationCoordinate2D){
    router?.presentMoreViewController(from: view! as! MapViewController, forCoordinates: coordinates)
  }
}

extension MapViewPresenter: MapInteractorToPresenterProtocol{
  
}
