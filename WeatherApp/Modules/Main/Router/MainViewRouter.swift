//
//  MainViewRouter.swift
//  WeatherApp
//
//  Created by Назар on 11/12/18.
//  Copyright © 2018 Nazar Voytovich. All rights reserved.
//

import Foundation
import UIKit

class MainViewRouter: PresenterToRouterProtocol {
  func presentMoreViewController(from view: MainViewController, forCity city: String){
    let moreViewController = MoreViewRouter.createMoreModule(forCity: city)
    if let sourceView = view as? UIViewController{
      sourceView.navigationController?.pushViewController(moreViewController, animated: true)
    }
  }
  
  func presentMapViewController(from view: MainViewController){
    let mapViewController = MapViewRouter.createMapModule()
    if let sourceView = view as? UIViewController{
      sourceView.navigationController?.pushViewController(mapViewController, animated: true)
    }
  }
  
  func presentAddViewController(from view: MainViewController){
    let addViewController = AddRouter.createAddModule()
    if let sourceView = view as? UIViewController{
      sourceView.navigationController?.pushViewController(addViewController, animated: true)
    }
  }
  
  class func presentMainModule() -> UIViewController {
    let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainViewController")
    if let view = viewController as? MainViewController {
      let presenter = MainViewPresenter()
      let interactor = MainViewInteractor()
      let router = MainViewRouter()
      let apiService = ApiService()
      let storageService = StorageServices()
      
      view.presenter = presenter
      
      presenter.view = view
      presenter.interactor = interactor
      presenter.router = router
      
      interactor.storageService = storageService
      interactor.presenter = presenter
      
      return viewController
    }
    return UIViewController()
  }
}
