//
//  HumidityProgressView.swift
//  WeatherApp
//
//  Created by Edgars on 15/02/2021.
//  Copyright © 2021 Edgars. All rights reserved.
//

import UIKit

final class HumidityProgressView: UIView {
    private var circleLayer = CAShapeLayer()
    private var progressLayer = CAShapeLayer()
    private var zeroLabel = UILabel()
    private var hundredLabel = UILabel()
    private var humidityLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        createCircularPath()
        addNumberLabels()
        addHumidityLabel()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        createCircularPath()
        addNumberLabels()
        addHumidityLabel()
    }

    private func addHumidityLabel() {
//        humidityLabel.font = .systemFont(ofSize: 20, weight: .bold)
//        humidityLabel.frame = CGRect(x: frame.width / 2 - 10, y: frame.height / 2 - 12.5, width: 50, height: 50)
//        addSubview(humidityLabel)
    }

    func setHumidity(to humidity: Int) {
        humidityLabel.text = "\(humidity)%"
    }

    private func addNumberLabels() {
        zeroLabel.text = "0"
        hundredLabel.text = "100"
        [zeroLabel, hundredLabel].forEach {
            $0.textColor = .gray
            $0.font = .systemFont(ofSize: 14, weight: .light)
        }

        zeroLabel.frame = CGRect(x: (frame.width / 2) - (frame.width / 3), y: frame.height - 10, width: 20, height: 20)
        hundredLabel.frame = CGRect(x: (frame.width / 2) + (frame.width / 5), y: frame.height - 10, width: 50, height: 20)

        addSubview(zeroLabel)
        addSubview(hundredLabel)
    }

    private func createCircularPath() {
        let circularPath = UIBezierPath(
            arcCenter: CGPoint(
                x: frame.size.width / 2,
                y: frame.size.height / 2),
            radius: frame.size.height / 2,
            startAngle: .pi - (.pi / 4),
            endAngle: .pi / 2 - (.pi / 4),
            clockwise: true)
        circleLayer.path = circularPath.cgPath
        circleLayer.fillColor = UIColor.clear.cgColor
        circleLayer.lineCap = .round
        circleLayer.lineWidth = 10.0
        circleLayer.strokeColor = UIColor.black.cgColor
        progressLayer.path = circularPath.cgPath
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.lineCap = .round
        progressLayer.lineWidth = 5.0
        progressLayer.strokeEnd = 0
        progressLayer.strokeColor = UIColor.white.cgColor
        layer.addSublayer(circleLayer)
        layer.addSublayer(progressLayer)
    }

    func addAnimation(progress: Double) {
        let circularProgressAnimation = CABasicAnimation(keyPath: "strokeEnd")
        circularProgressAnimation.duration = 2
        circularProgressAnimation.toValue = progress
        circularProgressAnimation.fillMode = .forwards
        circularProgressAnimation.isRemovedOnCompletion = false
        progressLayer.add(circularProgressAnimation, forKey: "progressAnim")
    }
}
