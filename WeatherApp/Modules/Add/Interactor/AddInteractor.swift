//
//  AddInteractor.swift
//  WeatherApp
//
//  Created by Назар on 11/24/18.
//  Copyright © 2018 Nazar Voytovich. All rights reserved.
//

import Foundation
import UIKit

class AddInteractor: AddPresenterToInteractorProtocol{
  var presenter: AddInteractorToPresenterProtocol?
  var storageService: StorageServicesProtocol?
  
  func citiesForSection(withHeader header:String, forCities cities: [String]) -> [String]{
    var array = [String]()
    for i in 0..<cities.count{
      let name = cities[i]
      let firstCharacter = String(name.characters.first!)
      if firstCharacter == header{
        array.append(name)
      }
    }
    return array
  }
}
