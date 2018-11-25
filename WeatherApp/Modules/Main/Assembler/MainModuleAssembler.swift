//
//  MainModuleAssembler.swift
//  WeatherApp
//
//  Created by Назар on 11/20/18.
//  Copyright © 2018 Nazar Voytovich. All rights reserved.
//

import UIKit
import Foundation

enum MainModuleAssembler {
  static func makeModule() -> UIViewController{
    let view = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
    let presenter = MainViewPresenter()
    let interactor = MainViewInteractor()
    let router = MainViewRouter()
    let storageServices = StorageServices()
    
    view.presenter = presenter
    
    presenter.view = view
    presenter.interactor = interactor
    presenter.router = router
    
    interactor.presenter = presenter
    interactor.storageService = storageServices
    
    
    return view
    
  }
}
