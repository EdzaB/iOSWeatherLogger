//
//  AppFlow.swift
//  WeatherApp
//
//  Created by Edgars on 13/02/2021.
//  Copyright © 2021 Edgars. All rights reserved.
//

import UIKit

final class AppFlow: FlowController {
    private var window: UIWindow
    private var rootController: UINavigationController?
    private var childFlow: FlowController?

    init(with window: UIWindow) {
        self.window = window
        window.makeKeyAndVisible()
    }

    func start() {
        let screenFlow = ScreenFlow(with: rootController)
        screenFlow.start()
        window.rootViewController = screenFlow.rootController
        childFlow = screenFlow
    }
}
