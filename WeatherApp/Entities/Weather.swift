//
//  Weather.swift
//  WeatherApp
//
//  Created by Назар on 11/7/18.
//  Copyright © 2018 Nazar Voytovich. All rights reserved.
//

import Foundation

struct Weather: Decodable {
  let id: Int
  let main: String
  let description: String
  let icon: String
}
