//
//  AddRouter.swift
//  WeatherApp
//
//  Created by Назар on 11/24/18.
//  Copyright © 2018 Nazar Voytovich. All rights reserved.
//

import Foundation
import UIKit

class AddRouter: AddPresenterToRouterProtocol {
  class func createAddModule() -> UIViewController {
    let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AddViewController")
    if let view = viewController as? AddViewController {
      let presenter = AddPresenter()
      let interactor = AddInteractor()
      let router = AddRouter()
      //let apiService = ApiService()
      let storageService = StorageServices()
      
      view.presenter = presenter
      
      presenter.view = view
      presenter.interactor = interactor
      presenter.router = router
      
      interactor.presenter = presenter
      interactor.storageService = storageService
      
      return viewController
    }
    return UIViewController()
  }
  
  func presentMoreViewController(from view: AddViewController, forCity city: String){
    let moreViewController = MoreViewRouter.createMoreModule(forCity: city)
    if let sourceView = view as? UIViewController{
      sourceView.navigationController?.pushViewController(moreViewController, animated: true)
    }
  }
}
