//
//  DetailsVM.swift
//  WeatherApp
//
//  Created by Edgars on 13/02/2021.
//  Copyright © 2021 Edgars. All rights reserved.
//

import Foundation

protocol PDetailVM {
    var reading: ReadingDO { get }
    func getCelsius(from kelvin: Double) -> String
}

final class DetailVM: PDetailVM {
    let reading: ReadingDO

    init(reading: ReadingDO) {
        self.reading = reading
    }

    func getCelsius(from kelvin: Double) -> String {
        return String(format: "%.0f", kelvin - 273.15)
    }
}
