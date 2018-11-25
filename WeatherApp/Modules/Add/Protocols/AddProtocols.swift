//
//  AddProtocols.swift
//  WeatherApp
//
//  Created by Назар on 11/24/18.
//  Copyright © 2018 Nazar Voytovich. All rights reserved.
//

import Foundation
import UIKit

protocol AddViewToPresenterProtocol: class{
  var view: AddPresenterToViewProtocol? {get set}
  var interactor: AddPresenterToInteractorProtocol? {get set}
  var router: AddPresenterToRouterProtocol? {get set}
  func cities(forCharacter character: String, forCities cities: [String]) -> [String]
  func showWeather(forCity city: String)
}

protocol AddPresenterToViewProtocol: class{
}

protocol AddPresenterToRouterProtocol: class {
  static func createAddModule() -> UIViewController
  func presentMoreViewController(from view: AddViewController, forCity city: String)
}

protocol AddPresenterToInteractorProtocol: class {
  var presenter:AddInteractorToPresenterProtocol? {get set}
  func citiesForSection(withHeader header:String, forCities cities: [String]) -> [String]
}

protocol AddInteractorToPresenterProtocol: class {
}
