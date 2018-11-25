//
//  Date.swift
//  WeatherApp
//
//  Created by Назар on 11/23/18.
//  Copyright © 2018 Nazar Voytovich. All rights reserved.
//

import Foundation

extension Date
{
  func toString( dateFormat format  : String ) -> String
  {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = format
    return dateFormatter.string(from: self)
  }
  
  static func second(from referenceDate: Date) -> Int {
    return Int(Date().timeIntervalSince(referenceDate).rounded())
  }
  
}
