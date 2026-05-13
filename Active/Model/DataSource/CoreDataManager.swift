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
            league.league_key = key
            league.league_name = name
            league.league_logo = logo
            league.sport_type = sport
        
        saveContext()
    }
    
    func deleteLeague(by key: String) {

        let request: NSFetchRequest<League> =
        League.fetchRequest()

        request.predicate =
        NSPredicate(format: "league_key == %@", key)

        do {

            let result = try context.fetch(request)

            if let league = result.first {

                context.delete(league)

                saveContext()
            }

        } catch {

            print(error.localizedDescription)
        }
    }
    
    func isLeagueFavorite(key: String) -> Bool {

        let request: NSFetchRequest<League> =
        League.fetchRequest()

        request.predicate =
        NSPredicate(format: "league_key == %@", key)

        do {

            let result = try context.fetch(request)

            return !result.isEmpty

        } catch {

            print(error.localizedDescription)

            return false
        }
    }
    

    
    
    
    // MARK: - Team Operations
        func fetchFavoriteTeams() -> [TeamEntity] {
            let request: NSFetchRequest<TeamEntity> = TeamEntity.fetchRequest()
            do {
                return try context.fetch(request)
            } catch {
                return []
            }
        }
        
        func saveTeam(key: Int64, name: String, logo: String, sport: String) {
            let team = TeamEntity(context: context)
            team.team_key = key
            team.team_name = name
            team.team_logo = logo
            team.sport_type = sport
            
            saveContext()
        }
        
        func deleteTeam(team: TeamEntity) {
            context.delete(team)
            saveContext()
        }
    
    func isTeamFavorite(key: Int64) -> Bool {
        let request: NSFetchRequest<TeamEntity> = TeamEntity.fetchRequest()
        request.predicate = NSPredicate(format: "team_key == %lld", key)
        do {
            let result = try context.fetch(request)
            return !result.isEmpty
        } catch {
            return false
        }
    }
        

   // MARK: - Save Context
    func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                print("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
}
