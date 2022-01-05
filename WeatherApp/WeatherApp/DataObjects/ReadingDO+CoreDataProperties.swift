//
//  ReadingDO+CoreDataProperties.swift
//  WeatherApp
//
//  Created by Edgars on 14/02/2021.
//  Copyright © 2021 Edgars. All rights reserved.
//
//

import Foundation
import CoreData


extension ReadingDO {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ReadingDO> {
        return NSFetchRequest<ReadingDO>(entityName: "ReadingDO")
    }

    @NSManaged public var speed: Double
    @NSManaged public var deg: Double
    @NSManaged public var temp: Double
    @NSManaged public var feelsLike: Double
    @NSManaged public var tempMin: Double
    @NSManaged public var tempMax: Double
    @NSManaged public var pressure: Int16
    @NSManaged public var humidity: Int16
    @NSManaged public var icon: String
    @NSManaged public var main: String
    @NSManaged public var sunrise: Double
    @NSManaged public var sunset: Double
    @NSManaged public var dateTime: Double
    @NSManaged public var name: String
    @NSManaged public var timezone: Int16
}
