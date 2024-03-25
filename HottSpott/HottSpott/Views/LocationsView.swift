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
    
    var body: some View {
        ZStack {
            mapLayer
                .ignoresSafeArea()
            
            VStack(spacing:0) {
                Spacer()
                locationsPreviewStack
            }
            
            if !vm.confirmedRating {
                RatingView()
                    .environmentObject(vm)
            }
        }
            
        
        
    }
}


struct LocationsView_Preview: PreviewProvider {
    static var previews: some View {
        LocationsView()
            .environmentObject(LocationsViewModel())
    }
}

extension LocationsView {
    private var mapLayer: some View {
        if !vm.confirmedRating {
            return Map(position: $vm.cameraPosition,
                       interactionModes: .zoom) {
                ForEach(vm.locations) { location in
                    Annotation(location.name, coordinate: location.coordinates) {
                        LocationMapAnnotationView()
                            .scaleEffect(vm.mapLocation == location ? 1 : 0.7)
                            .shadow(radius: 10)
                            .onTapGesture {
                                vm.showNextLocation(location: location)
                            }
                    }
                }
            }
        }
        return Map(position: $vm.cameraPosition) {
            ForEach(vm.locations) { location in
                Annotation(location.name, coordinate: location.coordinates) {
                    LocationMapAnnotationView()
                        .scaleEffect(vm.mapLocation == location ? 1 : 0.7)
                        .shadow(radius: 10)
                        .onTapGesture {
                            vm.showNextLocation(location: location)
                        }
                }
            }
        }
    }
    
    private var locationsPreviewStack: some View {
        LocationPreviewView(location: vm.mapLocation)
            .shadow(color: Color.black.opacity(0.3), radius: 20)
            .padding()
        // TODO: fix swipe bug here
            .transition(.asymmetric(
                insertion: .move(edge: .trailing),
                removal: .move(edge:.leading)))
            .environmentObject(vm)
    }
}
