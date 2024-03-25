//
//  LocationsView.swift
//  MapApp
//
//  Created by Ethan Ravelo on 3/18/24.
//

import SwiftUI
import MapKit




struct LocationsView: View {
    
    @EnvironmentObject private var vm: LocationsViewModel
    
    @State private var cameraPosition = MapCameraPosition.region(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 41.89, longitude: 12.49), span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)))
    
    
    var body: some View {
        ZStack {
            Map(position: $cameraPosition)
                .ignoresSafeArea()
        }
    }
}


struct LocationsView_Preview: PreviewProvider {
    static var previews: some View {
        LocationsView()
            .environmentObject(LocationsViewModel())
    }
}
