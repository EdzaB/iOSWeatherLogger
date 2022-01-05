//
//  ListVM.swift
//  WeatherApp
//
//  Created by Edgars on 13/02/2021.
//  Copyright © 2021 Edgars. All rights reserved.
//

import Foundation
import CoreLocation

protocol PListVM {
    var readings: [ReadingDO] { get set }
    var reloadCells: (() -> Void)? { get set }
    func getReading(from coordinates: CLLocationCoordinate2D)
    func deleteReading(at index: Int)
    func toDetails(for index: Int)
}

final class ListVM: PListVM {
    private var weatherService = WeatherService.shared
    private var persistanceService = PersistanceService.shared

    var reloadCells: (() -> Void)?
    var navigateToDetails: ((ReadingDO) -> Void)?
    var readings = [ReadingDO]() {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.persistanceService.save()
                self?.reloadCells?()
            }
        }
    }

    init() {
        persistanceService.fetch(ReadingDO.self) { (readings) in
            self.readings = readings
        }
    }

    func deleteReading(at index: Int) {
        persistanceService.context.delete(readings[index])
        readings.remove(at: index)
    }
    
    func getReading(from location: CLLocationCoordinate2D) {
        DispatchQueue.global().async { [weak self] in
            self?.weatherService.getData(for: LocationDO(lon: location.longitude, lat: location.latitude), completionHandler: { (resp) in
                self?.readings.append(resp)
            })
        }
    }

    func toDetails(for index: Int) {
        navigateToDetails?(readings[index])
    }
}
