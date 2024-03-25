//
//  LocationsViewModel.swift
//  MapApp
//
//  Created by Ethan Ravelo on 3/18/24.
//

import Foundation


class LocationsViewModel: ObservableObject {
    
    @Published var locations: [Location]
    
    init() {
        let locations = LocationsDataService.locations
        self.locations = locations
    }
    
}
