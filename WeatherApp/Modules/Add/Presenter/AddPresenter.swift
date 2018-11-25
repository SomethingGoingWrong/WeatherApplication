//
//  AddPresenter.swift
//  WeatherApp
//
//  Created by Назар on 11/24/18.
//  Copyright © 2018 Nazar Voytovich. All rights reserved.
//

import Foundation
import UIKit

class AddPresenter: AddViewToPresenterProtocol {
  var view: AddPresenterToViewProtocol?
  var interactor: AddPresenterToInteractorProtocol?
  var router: AddPresenterToRouterProtocol?
  
  func cities(forCharacter character: String, forCities cities: [String]) -> [String]{
    let array = interactor?.citiesForSection(withHeader: character, forCities: cities)
    return array!
  }
  func showWeather(forCity city: String){
    router?.presentMoreViewController(from: view as! AddViewController, forCity: city)
  }
}

extension AddPresenter: AddInteractorToPresenterProtocol{
  
}
