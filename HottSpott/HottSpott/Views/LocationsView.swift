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
    
    private func mainPreview(location: Location) -> some View {
        return LocationPreviewView(location: location)
            .shadow(color: Color.black.opacity(0.3), radius: 20)
            .padding()
            .environmentObject(vm)
    }
    
    private var locationsPreviewStack: some View {
        ZStack {
            mainPreview(location: vm.mapLocation)
                .offset(x: vm.swipeAmount)
                .gesture(
                    DragGesture()
                        .onChanged { gesture in
                            if vm.lastCord != 0 {
                                vm.swipeAmount += gesture.location.x-vm.lastCord
                            }
                            vm.lastCord = gesture.location.x
                        }
                        .onEnded { gesture in
                            vm.checkSwipeConditions()
                        }
                )
            if vm.swipeAmount > 75 {
                mainPreview(location: vm.lastLocation)
                    .offset(x: -UIScreen.main.bounds.width+vm.swipeAmount)
            }
            else if vm.swipeAmount < -76 {
                mainPreview(location: vm.nextLocation)
                    .offset(x:UIScreen.main.bounds.width+vm.swipeAmount)
            }
        }
    }
}
