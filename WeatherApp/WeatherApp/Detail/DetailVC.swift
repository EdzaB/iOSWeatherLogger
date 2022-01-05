//
//  Detail.swift
//  WeatherApp
//
//  Created by Edgars on 13/02/2021.
//  Copyright © 2021 Edgars. All rights reserved.
//

import UIKit

final class DetailVC: UIViewController {
    var viewModel: PDetailVM?
    @IBOutlet private weak var tempLabel: UILabel!
    @IBOutlet private weak var comfortLevelLabel: UILabel!
    @IBOutlet private weak var windLabel: UILabel!
    @IBOutlet private weak var sunLabel: UILabel!
    @IBOutlet private weak var scrollView: UIScrollView!

    @IBOutlet weak var humidityLabel: UILabel!
    //Animations
    @IBOutlet private weak var humidityProgressView: HumidityProgressView!

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadData()
    }

    private func loadData() {
        guard let viewModel = viewModel else { return }
        let reading = viewModel.reading
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, HH:mm"
        let dateTime = dateFormatter.string(from: Date(timeIntervalSince1970: reading.dateTime))
        dateFormatter.dateFormat = "HH:mm"
        dateFormatter.timeZone = TimeZone(secondsFromGMT: Int(reading.timezone))
        let sunrise = dateFormatter.string(from: Date(timeIntervalSince1970: reading.sunrise))
        let sunset = dateFormatter.string(from: Date(timeIntervalSince1970: reading.sunset))

        navigationItem.setTitle(title: reading.name, subtitle: "Taken: \(dateTime)")
        tempLabel.text =
            "Current: \(viewModel.getCelsius(from: reading.temp)) °C\n" +
            "Min: \(viewModel.getCelsius(from: reading.tempMin)) °C\n" +
            "Max: \(viewModel.getCelsius(from: reading.tempMax)) °C"
        comfortLevelLabel.text =
            "Feels like: \(viewModel.getCelsius(from: reading.feelsLike)) °C"
        windLabel.text =
            "Direction: \(reading.deg.direction)\n" +
            "Speed: \(Int(reading.speed * 3.6)) km/h"
        sunLabel.text =
            "Sunrise at: \(sunrise)\n" +
            "Sunset at: \(sunset)"

        humidityLabel.text = "\(reading.humidity)%"

        humidityProgressView.addAnimation(progress: Double(reading.humidity) / 100)
    }
}
