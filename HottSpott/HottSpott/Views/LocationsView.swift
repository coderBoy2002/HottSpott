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
            if !vm.confirmedRating {
                mapLayer
                    .ignoresSafeArea()
                    .opacity(0.1)
                
                VStack(spacing:0) {
                    Spacer()
                    SwipeView()
                        .environmentObject(vm)
                }
                .opacity(0.2)
    
                RatingView()
                    .environmentObject(vm)
            }
            else {
                mapLayer
                    .ignoresSafeArea()
                
                VStack(spacing:0) {
                    Spacer()
                    SwipeView()
                        .environmentObject(vm)
                }
            }
        }
    }
}

#Preview {
    LocationsView()
        .environmentObject(LocationsViewModel())
}

extension LocationsView {
    private var interactionModes: MapInteractionModes {
        if !vm.confirmedRating {
            return .zoom
        }
        return .all
    }
    private var mapLayer: some View {
        return Map(position: $vm.cameraPosition, interactionModes: interactionModes) {
            ForEach(vm.locations) { location in
                Annotation(location.name, coordinate: location.coordinates) {
                    LocationMapAnnotationView()
                        .scaleEffect(vm.mapLocation == location ? 1 : 0.7)
                        .shadow(radius: 10)
                        .onTapGesture {
                            vm.changeLocation(location: location)
                        }
                }
            }
        }
    }
}
