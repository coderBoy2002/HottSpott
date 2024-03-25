//
//  LocationPreviewView.swift
//  HottSpott
//
//  Created by Patrick Hutecker on 3/24/24.
//

import SwiftUI

struct LocationPreviewView: View {
    
    let location: Location
    
    @EnvironmentObject private var vm: LocationsViewModel
    
    @State var swipeAmount: CGFloat = 0
    let swipeCutOff: CGFloat = 50
    
    var body: some View {
        HStack(alignment: .bottom, spacing: 0) {
            VStack(alignment: .leading, spacing: 16) {
                imageSection
                titleSection
            }
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 10)
            .fill(.ultraThinMaterial)
            .offset(y: 65)
        )
        .cornerRadius(10)
        .offset(x: swipeAmount)
        .gesture(
          DragGesture()
              .onChanged { gesture in
                      swipeAmount = gesture.translation.width
                    
                  
              }
              .onEnded { gesture in
                  if swipeAmount > swipeCutOff {
                      vm.lastLocation()
                  } else if swipeAmount < -swipeCutOff {
                      vm.nextLocation()
                  }
                  swipeAmount = 0
              }
        )
        
          
        
    }
}

#Preview {
    ZStack {
        Color.blue.ignoresSafeArea()
        
        LocationPreviewView(location: LocationsDataService.locations.first!)
            .padding()
    }
}

extension LocationPreviewView {
    private var imageSection: some View {
        ZStack {
            if let imageName = location.imageNames.first {
                Image(imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 100)
                    .cornerRadius(10)
            }
        }
        .padding(6)
        .background(Color.white)
        .cornerRadius(10)
    }
    
    private var titleSection: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(location.name)
                .font(.title2)
                .fontWeight(.bold)
            
            Text(location.cityName)
                .font(.subheadline)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
}

