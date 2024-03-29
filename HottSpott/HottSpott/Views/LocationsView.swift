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
                mainArea
                .opacity(0.2)
    
                RatingView()
                    .environmentObject(vm)
                    //.blur(radius: 1, opaque: false)
            }
            else {
            mainArea
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
    
    private var header: some View {
        return ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.white)
                .frame(height: 200)
                .cornerRadius(70)
                .opacity(0.6)
            Text("HottSpott")
                .offset(y: 70)
                .padding()
                .foregroundStyle(.black)
                .font(.title2)
                .fontWeight(.bold)
        }
        .offset(y: -UIScreen.main.bounds.height / 2)
    }
    
    private var mainArea: some View {
        ZStack {
            mapLayer
                .ignoresSafeArea()
            header
                .ignoresSafeArea()
            
            VStack(spacing:0) {
                Spacer()
                SwipeView()
                    .environmentObject(vm)
            }
        }
    }
}
