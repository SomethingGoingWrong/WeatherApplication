//
//  StorageService.swift
//  WeatherApp
//
//  Created by Назар on 11/7/18.
//  Copyright © 2018 Nazar Voytovich. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

protocol StorageServicesProtocol: class{
  func savedCitiesNames() -> [String]?
  func deleteCity(forCity city:String)
  func addCity(forCity city:String)
}

class StorageServices: StorageServicesProtocol {
  
  
  func savedCitiesNames() -> [String]? {
    let realm = try! Realm()
    let count = realm.objects(City.self).count
    var names = [String]()
    
    for i in 0..<count {
      let name = realm.objects(City.self)[i].name
      names.append(name)
    }
    return names
  }
  
  func deleteCity(forCity city:String){
    let realm = try! Realm()
    print("\(city)")
    let object = realm.objects(City.self).filter("name == %@", city).first
    do {
      try realm.write({
        realm.delete(object!)
      })
    }catch let error {
      print(error)
    }
  }
  
  func addCity(forCity city:String){
    let realm = try! Realm()
    let object = City()
    object.name = city
    do {
      try realm.write({
        realm.add(object)
        print("City added")
      })
    }catch let error {
      print(error)
    }
  }
}
