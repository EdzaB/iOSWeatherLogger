//
//  Direction.swift
//  WeatherApp
//
//  Created by Edgars on 14/02/2021.
//  Copyright © 2021 Edgars. All rights reserved.
//

import Foundation

enum Direction: String, CaseIterable {
    case n, nne, ne, ene, e, ese, se, sse, s, ssw, sw, wsw, w, wnw, nw, nnw
}

extension Direction: CustomStringConvertible  {
    init<D: BinaryFloatingPoint>(_ direction: D) {
        self = Direction.allCases[Int((direction.angle+11.25).truncatingRemainder(dividingBy: 360)/22.5)]
    }
    var description: String { return rawValue.uppercased() }
}

extension BinaryFloatingPoint {
    var angle: Self {
        return (truncatingRemainder(dividingBy: 360) + 360).truncatingRemainder(dividingBy: 360)
    }
    var direction: Direction { return Direction(self) }
}
