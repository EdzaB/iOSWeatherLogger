//
//  ListCell.swift
//  WeatherApp
//
//  Created by Edgars on 13/02/2021.
//  Copyright © 2021 Edgars. All rights reserved.
//

import UIKit

final class ListCell: UITableViewCell {
    static let nib = UINib(nibName: ListCell.identifier, bundle: nil)
    static let identifier = String(describing: ListCell.self)
    
    @IBOutlet private weak var iconImageView: UIImageView!
    @IBOutlet private weak var descLabel: UILabel!
    @IBOutlet private weak var tempLabel: UILabel!
    @IBOutlet private weak var nameDateLabel: UILabel!

    func setData(temp: Double?, date: Date, icon: String?, desc: String?, name: String?, timezone: Int16?) {
        guard let temp = temp,
            let icon = icon,
            let desc = desc,
            let name = name,
            let timezone = timezone
            else { return }
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(secondsFromGMT: Int(timezone))
        formatter.dateFormat = "HH:mm"
        nameDateLabel.text = name + " at \n\(formatter.string(from: date))"
        tempLabel.text = "\(String(format: "%.0f", temp - 273.15)) °C"
        iconImageView.image = UIImage(named: icon)
        descLabel.text = desc
    }
}
