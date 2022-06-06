//
//  Park.swift
//  NationalParks
//
//  Created by Sean Grogg on 4/10/22.
//

import Foundation
import MapKit

class Park: CustomDebugStringConvertible, Codable {
    
    var debugDescription: String {
        return "Park(name: \(self.name), description: \(self.description), state: \(self.state), size: \(self.size), yearFounded: \(self.yearFounded), lat: \(self.lat), long: \(self.long)"
    }
    
    
    var name: String
    var description: String
    var imageURL: String
    var state: String
    var size: String
    var yearFounded: String
    var hikingURL: String
    var lat: String
    var long: String
    var coordinate: CLLocationCoordinate2D
    var confirmedVisit: Bool = false
    var confirmedFavorite: Bool = false
    
    private enum CodingKeys: String, CodingKey {
        case name, description, imageURL, state, lat, long, size, hikingURL, yearFounded
    }
    
    init(named name: String, description: String, imageURL: String, state: String, lat: String, long: String, size: String, hikingURL: String, yearFounded: String){
        
        self.name = name
        self.description = description
        self.imageURL = imageURL
        self.state = state
        self.lat = lat
        self.long = long
        
        //Figured out how to create this attribute from a string through this StackOverflow Post
        //https://stackoverflow.com/questions/38922258/how-to-convert-string-to-cllocationdegrees-swift-2
        self.coordinate = CLLocationCoordinate2D(latitude: Double(self.lat)!, longitude: Double(self.long)!)
        self.size = size
        self.hikingURL = hikingURL
        self.yearFounded = yearFounded
        
    }
   required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.description = try container.decode(String.self, forKey: .description)
        self.imageURL = try container.decode(String.self, forKey: .imageURL)
        self.state = try container.decode(String.self, forKey: .state)
        self.lat = try container.decode(String.self, forKey: .lat)
        self.long = try container.decode(String.self, forKey: .long)
        self.coordinate = CLLocationCoordinate2D(latitude: Double(self.lat)!, longitude: Double(self.long)!)
        self.size = try container.decode(String.self, forKey: .size)
        self.hikingURL = try container.decode(String.self, forKey: .hikingURL)
        self.yearFounded = try container.decode(String.self, forKey: .yearFounded)
      }
    
    struct ParkResult: Codable {
        let parks: [Park]
    }
}
