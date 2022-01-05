//
//  ScreenFlow.swift
//  WeatherApp
//
//  Created by Edgars on 13/02/2021.
//  Copyright © 2021 Edgars. All rights reserved.
//

import UIKit

final class ScreenFlow: FlowController {
    var rootController: UINavigationController?
    
    init(with rootController: UINavigationController?) {
        self.rootController = rootController
    }

    private lazy var listVC: ListVC? = {
        let sb = UIStoryboard(name: StoryboardEnum.listSB.rawValue, bundle: Bundle.main)
        return sb.instantiateInitialViewController() as? ListVC
    }()

    private lazy var detailVC: DetailVC? = {
        let sb = UIStoryboard(name: StoryboardEnum.detailSB.rawValue, bundle: Bundle.main)
        return sb.instantiateInitialViewController() as? DetailVC
    }()

    func start() {
        guard let vc = listVC else { return }
        let vm = ListVM()
        vm.navigateToDetails = { [weak self] reading in
            self?.navigateToDetails(with: reading)
        }
        vc.viewModel = vm
        rootController = UINavigationController(rootViewController: vc)
    }

    private func navigateToDetails(with reading: ReadingDO) {
        guard let vc = detailVC else { return }
        vc.viewModel = DetailVM(reading: reading)
        rootController?.pushViewController(vc, animated: true)
    }
}
