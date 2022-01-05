//
//  WeatherApi.swift
//  WeatherApp
//
//  Created by Edgars on 13/02/2021.
//  Copyright © 2021 Edgars. All rights reserved.
//

import Foundation

protocol PWeatherService {
    func getData(for location: LocationDO, completionHandler: @escaping ((ReadingDO) -> Void))
}

final class WeatherService: PWeatherService {
    static let shared: PWeatherService = WeatherService()
    //Normaly we would use a .plist file that we would not commit to repository for the API key
    private let apiKey = "6dff3befe5a4bc9a2c8c2c7cd5a15784"
    private let persistance = PersistanceService.shared

    func getData(for location: LocationDO, completionHandler: @escaping ((ReadingDO) -> Void)) {
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(location.lat)&lon=\(location.lon)&appid=\(apiKey)") else { return }
        let task = URLSession.shared.dataTask(with: url, completionHandler: { [weak self] (data, response, error) in
            if let error = error {
                print("Error with fetching weather data: \(error)")
                return
            }

            guard let httpResponse = response as? HTTPURLResponse,
                (200...299).contains(httpResponse.statusCode) else {
                    print("Error with the response, unexpected status code: \(String(describing: response))")
                    return
            }

            //JSON decoding (Could also be done with Codable but results in a more complicated Core Data usage)
            guard
                let self = self,
                let data = data,
                let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                let coord = json["coord"] as? [String: Any],
                let weatherArray = json["weather"] as? [[String: Any]],
                let weather = weatherArray.first,
                let main = json["main"] as? [String: Any],
                let wind = json["wind"] as? [String: Any],
                let sys = json["sys"] as? [String: Any],
                let temp = main["temp"] as? Double,
                let feelsLike = main["feels_like"] as? Double,
                let tempMin = main["temp_min"] as? Double,
                let tempMax = main["temp_max"] as? Double,
                let pressure = main["pressure"] as? Int16,
                let humidity = main["humidity"] as? Int16,
                let speed = wind["speed"] as? Double,
                let degrees = wind["deg"] as? Double,
                let sunrise = sys["sunrise"] as? Double,
                let sunset = sys["sunset"] as? Double,
                let icon = weather["icon"] as? String,
                let mainDesc = weather["main"] as? String,
                let dateTime = json["dt"] as? Double,
                let name = json["name"] as? String,
                let timezone = json["timezone"] as? Int16
                else { return }

            let reading = ReadingDO(context: self.persistance.context)
            reading.temp = temp
            reading.feelsLike = feelsLike
            reading.tempMin = tempMin
            reading.tempMax = tempMax
            reading.pressure = pressure
            reading.humidity = humidity
            reading.speed = speed
            reading.deg = degrees
            reading.dateTime = dateTime
            reading.sunrise = sunrise
            reading.sunset = sunset
            reading.name = name
            reading.main = mainDesc
            reading.icon = icon
            reading.timezone = timezone

            completionHandler(reading)
        })
        task.resume()
    }
}

