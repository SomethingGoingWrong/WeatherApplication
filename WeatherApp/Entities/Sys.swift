//
//  Sys.swift
//  WeatherApp
//
//  Created by Назар on 11/7/18.
//  Copyright © 2018 Nazar Voytovich. All rights reserved.
//

import Foundation

struct Sys: Decodable {
  let type: Int
  let id: Int
  let message: Double
  let country: String
  let sunrise: Int
  let sunset: Int
}
