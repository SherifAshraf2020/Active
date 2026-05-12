//
//  TeamEntity+CoreDataProperties.swift
//  Active
//
//  Created by Sherif Ashraf Farooq  on 10/05/2026.
//
//

import Foundation
import CoreData


extension TeamEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TeamEntity> {
        return NSFetchRequest<TeamEntity>(entityName: "TeamEntity")
    }

    @NSManaged public var team_key: Int64
    @NSManaged public var team_name: String?
    @NSManaged public var team_logo: String?
    @NSManaged public var sport_type: String?

}

extension TeamEntity : Identifiable {

}
