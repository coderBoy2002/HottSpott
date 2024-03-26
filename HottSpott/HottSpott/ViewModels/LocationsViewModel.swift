//
//  LocationsViewModel.swift
//  MapApp
//
//  Created by Ethan Ravelo on 3/18/24.
//

import Foundation
import MapKit
import SwiftUI

class LocationsViewModel: ObservableObject {
    
    // All loaded locations
    @Published var locations: [Location]
    
    @Published var mapLocation: Location
    @Published var nextLocation: Location
    @Published var lastLocation: Location
    
    @Published var cameraPosition: MapCameraPosition = MapCameraPosition.region(MKCoordinateRegion())
    let mapSpan = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    
    @Published var confirmedRating: Bool = false
    
    @Published var swipeAmount: CGFloat = 0
    let swipeCutOff: CGFloat = 50
    
    init() {
        let locations = LocationsDataService.locations
        self.locations = locations
        self.mapLocation = locations.first!
        self.nextLocation = locations.first!
        self.lastLocation = locations.last!
        self.changeLocation(location: locations.first!)
    }
    
    func changeLocation(location: Location) {
        withAnimation(.spring) {
            cameraPosition = MapCameraPosition.region(MKCoordinateRegion(
                center: location.coordinates,
                span: mapSpan))
            mapLocation = location
            nextLocation = getNextLocation()
            lastLocation = getLastLocation()
        }
    }
    
    func getNextLocation() -> Location {
        // Get the current index
        guard let currentIndex = locations.firstIndex(where: { $0 == mapLocation }) else {
            return locations.first!
        }
        
        // Check if currentIndex is valid
        let nextIndex = currentIndex + 1
        guard locations.indices.contains(nextIndex) else {
            return locations.first!
        }
        
        // Next index IS valid
        let nextLocation = locations[nextIndex]
        return nextLocation
    }
    
    func getLastLocation() -> Location {
        // Get the current index
        guard let currentIndex = locations.firstIndex(where: { $0 == mapLocation }) else {
            return locations.first!
        }
        
        // Check if currentIndex is valid
        let nextIndex = currentIndex - 1
        guard locations.indices.contains(nextIndex) else {
            return locations.last!
        }
        
        // Next index IS valid
        let nextLocation = locations[nextIndex]
        return nextLocation
    }
    
    func checkSwipeConditions() {
        if swipeAmount > swipeCutOff {
            changeLocation(location: lastLocation)
        } else if swipeAmount < -swipeCutOff {
            changeLocation(location: nextLocation)
        }
        swipeAmount = 0
    }

    
}
