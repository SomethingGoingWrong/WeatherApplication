//
//  Main.swift
//  WeatherApp
//
//  Created by Назар on 11/7/18.
//  Copyright © 2018 Nazar Voytovich. All rights reserved.
//

import Foundation

struct Main: Decodable {
  let temp: Double
  let pressure: Double
  let humidity: Int
  let temp_min: Double
  let temp_max: Double
}
