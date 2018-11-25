//
//  MainViewInteractor.swift
//  WeatherApp
//
//  Created by Назар on 11/12/18.
//  Copyright © 2018 Nazar Voytovich. All rights reserved.
//

import Foundation
import UIKit

class MainViewInteractor: PresenterToInteractorProtocol {
  
  var presenter: InteractorToPresenterProtocol?
  var storageService: StorageServicesProtocol?
  
  
  func getCitiesNames(){
    let cities = storageService!.savedCitiesNames()
    if cities != nil{
      self.presenter?.citiesNamesGoted(cities: cities!)
    }else{
      self.presenter?.citiesNamesGotedFail()
    }
  }
}
