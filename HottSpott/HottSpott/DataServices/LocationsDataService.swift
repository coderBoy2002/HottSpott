//
//  LocationsDataService.swift
//  MapTest
//
//  Created by Nick Sarno on 11/26/21.
//

import Foundation
import MapKit

class LocationsDataService {
    
    static let locations: [Location] = [
        Location(
            name: "West",
            cityName: "Mudd",
            coordinates: CLLocationCoordinate2D(latitude: 34.10569578206989, longitude: -117.7089185186897),
            description: "WIBSTR",
            imageNames: [
                "west-mudd-1",
            ],
            link: "https://en.wikipedia.org"),
        Location(
            name: "North",
            cityName: "Mudd",
            coordinates: CLLocationCoordinate2D(latitude: 34.10648005068195, longitude: -117.70822782203626),
            description: "Norf Dorm",
            imageNames: [
                "north-mudd-1",
            ],
            link: "https://en.wikipedia.org"),
        Location(
            name: "Linde",
            cityName: "Mudd",
            coordinates: CLLocationCoordinate2D(latitude: 34.10599176489909, longitude: -117.70556399481829),
            description: "Linde sucks",
            imageNames: [
                "linde-mudd-1",
            ],
            link: "https://en.wikipedia.org"),
    ]
    
}
