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
    
    /*
    private var locationsPreviewStackHelper: some View {
        LocationPreviewView(location: vm.mapLocation)
            .shadow(color: Color.black.opacity(0.3), radius: 20)
            .padding()
        // TODO: fix swipe bug here
            .environmentObject(vm)
            .transition(.asymmetric(
                insertion: .move(edge: .leading),
                removal: .move(edge:.trailing)))
        
    }
     */
    
    private var locationsPreviewStack: some View {
        HStack {
            LocationPreviewView(location: vm.mapLocation)
                .shadow(color: Color.black.opacity(0.3), radius: 20)
                .padding()
            // TODO: fix swipe bug here
                .environmentObject(vm)
                .offset(x: vm.swipeAmount)
                .gesture(
                    DragGesture()
                        .onChanged { gesture in
                            vm.swipeAmount = gesture.translation.width
                        }
                        .onEnded { gesture in
                            vm.checkSwipeConditions()
                        }
                )
            Spacer()
            if abs(vm.swipeAmount) > 0 {
                LocationPreviewView(location: vm.nextLocation)
                    .shadow(color: Color.black.opacity(0.3), radius: 20)
                    .padding()
                    .offset(x: 50 - abs(vm.swipeAmount))
            }
            
        }
    }
}
