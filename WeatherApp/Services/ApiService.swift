//
//  ApiService.swift
//  WeatherApp
//
//  Created by Назар on 11/7/18.
//  Copyright © 2018 Nazar Voytovich. All rights reserved.
//

import Foundation
import Alamofire
import CoreLocation
import Kingfisher
import UIKit

protocol ApiServiceProtocol: class {
  func getWeathers(withCity city: String,success: @escaping (GeneralResponse) -> Void, failure: @escaping (Error) -> Void)
  func getWeatherByCoordinates(withCoordinates coordinates: CLLocationCoordinate2D,success: @escaping (GeneralResponse) -> Void, failure: @escaping (Error) -> Void)
}

class ApiService: ApiServiceProtocol {
  func getWeathers(withCity city: String,success: @escaping (GeneralResponse) -> Void, failure: @escaping (Error) -> Void){
    Alamofire.request("http://api.openweathermap.org/data/2.5/forecast?q=\(city)&appid=32c33a8b0935293e99cda17499cb9b4f").responseJSON{ response in
      let data = response.data
      if data != nil{
        let decoder = JSONDecoder()
        let result = try? decoder.decode(GeneralResponse.self, from: data!)
        if result != nil{
          success(result!)
        }else{
          let error = response.result.error
          failure(error!)
        }
      }
    }
  }
  func getWeatherByCoordinates(withCoordinates coordinates: CLLocationCoordinate2D,success: @escaping (GeneralResponse) -> Void, failure: @escaping (Error) -> Void){
    Alamofire.request("https://samples.openweathermap.org/data/2.5/forecast?lat=\(coordinates.latitude)&lon=\(coordinates.longitude)&appid=32c33a8b0935293e99cda17499cb9b4f").responseJSON{ response in
      let data = response.data
      if data != nil{
        let decoder = JSONDecoder()
        let result = try? decoder.decode(GeneralResponse.self, from: data!)
        success(result!)
      }else{
        let error = response.result.error
        failure(error!)
      }
    }
  }
 }
  
  



