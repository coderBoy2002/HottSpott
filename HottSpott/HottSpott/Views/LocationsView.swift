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
                Map(position: $vm.cameraPosition,
                    interactionModes: .zoom)
                    .ignoresSafeArea()
                
            }
            else {
                Map(position: $vm.cameraPosition)
                    .ignoresSafeArea()
            }

            

            
            VStack(spacing:0) {
                Spacer()
                
                LocationPreviewView(location: vm.mapLocation)
                    .shadow(color: Color.black.opacity(0.3), radius: 20)
                    .padding()
                // TODO: fix swipe bug here
                    .transition(.asymmetric(
                        insertion: .move(edge: .trailing),
                        removal: .move(edge:.leading)))
                    .environmentObject(vm)
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
