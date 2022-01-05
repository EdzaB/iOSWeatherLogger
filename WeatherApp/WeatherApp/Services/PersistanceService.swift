//
//  PersistanceService.swift
//  WeatherApp
//
//  Created by Edgars on 14/02/2021.
//  Copyright © 2021 Edgars. All rights reserved.
//

import Foundation
import CoreData

final class PersistanceService {

    private init() {}
    static let shared = PersistanceService()
    var context: NSManagedObjectContext { return persistanceContainer.viewContext }

    lazy var persistanceContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "ListModel")
        container.loadPersistentStores(completionHandler: { (storeDesc, error) in
            if let error = error as NSError? {
                print(error)
            }
        })
        return container
    }()

    func save() {
        let context = persistanceContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
                print("saved")
            } catch {
                print("Saving error: ", error)
            }
        }
    }

    func fetch<T: NSManagedObject>(_ type: T.Type, completionHandler: @escaping ([T]) -> Void) {
        let request = NSFetchRequest<T>(entityName: String(describing: type))
        do {
            let obj = try context.fetch(request)
            completionHandler(obj)
        } catch {
            print(error)
            completionHandler([])
        }
    }
}
