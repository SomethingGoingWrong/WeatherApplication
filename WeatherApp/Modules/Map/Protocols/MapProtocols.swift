//
//  MapProtocols.swift
//  WeatherApp
//
//  Created by Назар on 11/23/18.
//  Copyright © 2018 Nazar Voytovich. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

protocol MapViewToPresenterProtocol: class{
  var view: MapPresenterToViewProtocol? {get set}
  var interactor: MapPresenterToInteractorProtocol? {get set}
  var router: MapPresenterToRouterProtocol? {get set}
  func showWeather(forCoordinates coordinates: CLLocationCoordinate2D)

}

protocol MapPresenterToViewProtocol: class{

}

protocol MapPresenterToRouterProtocol: class {
 func presentMoreViewController(from view: MapViewController, forCoordinates coordinates: CLLocationCoordinate2D)
 static func createMapModule() -> UIViewController
}

protocol MapPresenterToInteractorProtocol: class {
  var presenter: MapInteractorToPresenterProtocol? {get set}

}

protocol MapInteractorToPresenterProtocol: class {
}
