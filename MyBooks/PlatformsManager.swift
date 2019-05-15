//
//  PlatformsManager.swift
//  MyBooks
//
//  Created by Rafael Oliveira on 12/05/19.
//  Copyright © 2019 Rafael Oliveira. All rights reserved.
//

import CoreData

class PlatformsManager {
    static let shared = PlatformsManager()
    var platforms:[Platform] = []
    
    func loadPlatforms(with context: NSManagedObjectContext){
        let fetchRequest: NSFetchRequest<Platform> = Platform.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        do {
            platforms = try context.fetch(fetchRequest)
        } catch  {
            print(error.localizedDescription)
        }
    }
    
    func deletePlatforms(index: Int, context:NSManagedObjectContext){
        let platform = platforms[index]
        context.delete(platform)
        do {
            try context.save()
            platforms.remove(at: index)
        } catch {
            print(error.localizedDescription)
        }
    }
    private init(){
    }
}
