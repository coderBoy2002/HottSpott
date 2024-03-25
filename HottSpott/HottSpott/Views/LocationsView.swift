//
//  LocationsView.swift
//  MapApp
//
//  Created by Ethan Ravelo on 3/18/24.
//

import SwiftUI
import MapKit


extension CLLocationCoordinate2D {
    static let parking = CLLocationCoordinate2D(latitude: 42.35, longitude: -71.06)
}


struct LocationsView: View {
    
    @EnvironmentObject private var vm: LocationsViewModel
    @State private var searchText = ""
    
    var body: some View {
        Map {
            MapCircle(center: .parking, radius: 20)
                .foregroundStyle(.orange.opacity(0.25))
        }
        .overlay(alignment: .top) {
            TextField("Search for a locaiton...", text: $searchText)
                .font(.subheadline)
                .padding(12)
                .background(.white)
                .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
        }
        .onSubmit(of: .text) {
            print("Search for locations with query \(searchText)")
        }
        .mapControls {
            MapCompass()
            MapPitchToggle()
            MapUserLocationButton()
        }
    }
}


struct LocationsView_Preview: PreviewProvider {
    static var previews: some View {
        LocationsView()
            .environmentObject(LocationsViewModel())
    }
}
