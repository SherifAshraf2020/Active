//
//  CoreDataManager.swift
//  Active
//
//  Created by Sherif Ashraf Farooq  on 08/05/2026.
//

import UIKit
import CoreData

class CoreDataManager {
    
    static let shared = CoreDataManager()
    private init() {}

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func fetchFavorites() -> [League] {
        let request: NSFetchRequest<League> = League.fetchRequest()
        do {
            return try context.fetch(request)
        } catch {
            return []
        }
    }
    
    func saveLeague(key: String, name: String, logo: String, sport: String) {
            let league = League(context: context)
            
            league.league_name = name
            league.league_logo = logo
            league.sport_type = sport
        
        saveContext()
    }
    
    func deleteLeague(league: League) {
        context.delete(league)
        saveContext()
    }
    
    func saveContext() {
        if context.hasChanges {
            try? context.save()
        }
    }
}
