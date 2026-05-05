//
//  League+CoreDataProperties.swift
//  Active
//
//  Created by Sherif Ashraf Farooq  on 05/05/2026.
//
//

import Foundation
import CoreData


extension League {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<League> {
        return NSFetchRequest<League>(entityName: "League")
    }

    @NSManaged public var league_key: String?
    @NSManaged public var league_name: String?
    @NSManaged public var league_logo: String?
    @NSManaged public var sport_type: String?

}

extension League : Identifiable {

}
