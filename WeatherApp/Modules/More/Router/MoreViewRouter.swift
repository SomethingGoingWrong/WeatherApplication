//
//  MoreViewRouter.swift
//  WeatherApp
//
//  Created by Назар on 11/21/18.
//  Copyright © 2018 Nazar Voytovich. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

class MoreViewRouter: MorePresenterToRouterProtocol {
  class func createMoreModule(forCity city: String) -> UIViewController {
    let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MoreViewController")
    if let view = viewController as? MoreViewController {
      let presenter = MoreViewPresenter()
      let interactor = MoreViewInteractor()
      let router = MoreViewRouter()
      let apiService = ApiService()
      let storageService = StorageServices()
      
      view.presenter = presenter
      view.city = city
      
      presenter.view = view
      presenter.interactor = interactor
      presenter.router = router
      
      interactor.apiService = apiService
      interactor.storageService = storageService
      interactor.presenter = presenter
      
      return viewController
    }
    return UIViewController()
  }
  
  class func createMoreModuleByCoordinates(forCoordinates coordinates: CLLocationCoordinate2D) -> UIViewController {
    let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MoreViewController")
    if let view = viewController as? MoreViewController {
      let presenter = MoreViewPresenter()
      let interactor = MoreViewInteractor()
      let router = MoreViewRouter()
      let apiService = ApiService()
      let storageService = StorageServices()

      
      view.presenter = presenter
      view.location = coordinates
      
      presenter.view = view
      presenter.interactor = interactor
      presenter.router = router
      
      interactor.apiService = apiService
      interactor.presenter = presenter
      interactor.storageService = storageService
      
      return viewController
    }
    return UIViewController()
  }
  
  func presentMainViewController(from view: MoreViewController){
    let mainViewController = MainViewRouter.presentMainModule()
    if let sourceView = view as? UIViewController{
      sourceView.navigationController?.pushViewController(mainViewController, animated: true)
    }
  }
}
