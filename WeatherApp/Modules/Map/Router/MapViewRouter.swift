//
//  MapViewRouter.swift
//  WeatherApp
//
//  Created by Назар on 11/23/18.
//  Copyright © 2018 Nazar Voytovich. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

class MapViewRouter: MapPresenterToRouterProtocol {
  class func createMapModule() -> UIViewController {
    let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MapViewController")
    if let view = viewController as? MapViewController {
      let presenter = MapViewPresenter()
      let interactor = MapViewInteractor()
      let router = MapViewRouter()
      let apiService = ApiService()
      
      view.presenter = presenter
      
      presenter.view = view
      presenter.interactor = interactor
      presenter.router = router
      
      interactor.apiService = apiService
      interactor.presenter = presenter
      
      return viewController
    }
    return UIViewController()
  }
  
  func presentMoreViewController(from view: MapViewController, forCoordinates coordinates: CLLocationCoordinate2D){
    let moreViewController = MoreViewRouter.createMoreModuleByCoordinates(forCoordinates: coordinates)
    if let sourceView = view as? UIViewController{
      sourceView.navigationController?.pushViewController(moreViewController, animated: true)
    }
  }
}
