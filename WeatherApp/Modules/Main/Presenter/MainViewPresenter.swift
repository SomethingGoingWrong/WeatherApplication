//
//  MainViewPresenter.swift
//  WeatherApp
//
//  Created by Назар on 11/12/18.
//  Copyright © 2018 Nazar Voytovich. All rights reserved.
//

import Foundation
import UIKit

class MainViewPresenter: ViewToPresenterProtocol{
  var view: PresenterToViewProtocol?
  var interactor: PresenterToInteractorProtocol?
  var router: PresenterToRouterProtocol?
  
  func updateView(){
    interactor?.getCitiesNames()
  }
  func shomMore(forCity city: String){
    router?.presentMoreViewController(from: view! as! MainViewController, forCity: city)
  }
  func showMap(){
    router?.presentMapViewController(from: view! as! MainViewController)
  }
  func showAddView(){
    router?.presentAddViewController(from: view! as! MainViewController)
  }
}

extension MainViewPresenter: InteractorToPresenterProtocol{
  func citiesNamesGoted(cities: [String]){
    view?.showCells(withCities: cities)
  }
  func citiesNamesGotedFail(){
    view?.showError()
  }
  
}
