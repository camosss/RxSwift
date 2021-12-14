//
//  URL+Extension.swift
//  GoodWeather
//
//  Created by 강호성 on 2021/12/14.
//

import Foundation

extension URL {
    static func urlForWeatherAPI(city: String) -> URL? {
        return URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=3bd336680248f3f4d90c941f6d034673&units=metric")
    }
}
