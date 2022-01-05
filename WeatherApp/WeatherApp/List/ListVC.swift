//
//  List.swift
//  WeatherApp
//
//  Created by Edgars on 13/02/2021.
//  Copyright © 2021 Edgars. All rights reserved.
//

import UIKit
import CoreLocation

final class ListVC: UIViewController {
    @IBOutlet private weak var tableView: UITableView!
    private var locationManager = CLLocationManager()
    var viewModel: PListVM?

    override func viewDidLoad() {
        setupTableView()
        setupLocation()
    }

    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ListCell.nib, forCellReuseIdentifier: ListCell.identifier)
        viewModel?.reloadCells = { [weak self] in
            self?.tableView.reloadData()
        }
    }

    private func setupLocation() {
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
        locationManager.requestWhenInUseAuthorization()
    }

    @IBAction private func saveButtonTouched(_ sender: UIButton) {
        guard let coordinates = locationManager.location?.coordinate else { return }
        viewModel?.getReading(from: coordinates)
    }
}

extension ListVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.readings.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ListCell.identifier, for: indexPath)
        let reading = viewModel?.readings[indexPath.row]
        (cell as? ListCell)?.setData(temp: reading?.temp,
                                     date: Date(timeIntervalSince1970: reading?.dateTime ?? 0),
                                     icon: reading?.icon,
                                     desc: reading?.main,
                                     name: reading?.name,
                                     timezone: reading?.timezone)
        return cell
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            viewModel?.deleteReading(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        default:
            break
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel?.toDetails(for: indexPath.row)
    }
}

extension ListVC: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {}
}
