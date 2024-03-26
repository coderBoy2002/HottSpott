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
    
    var body: some View {
        HStack(alignment: .bottom, spacing: 0) {
            HStack(alignment: .bottom, spacing: 16) {
                imageSection
                titleSection
            }
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 20)
            .fill(.ultraThinMaterial)
            .background(Color("AccentColor"))
            .cornerRadius(20)
            .offset(y: 65)
        )
        .cornerRadius(20)
        .frame(width: 310, height: 180)
    }
}

#Preview {
    ZStack {
        
        LocationPreviewView(location: LocationsDataService.locations.first!)
            .padding()
    }
}

extension LocationPreviewView {
    private var imageSection: some View {
        ZStack {
            Image(systemName: "eye.trianglebadge.exclamationmark.fill")
                .resizable()
                .frame(width: 150, height: 80)
                .padding(6)
                .scaledToFill()
                .cornerRadius(10)
        }
        .padding(7)
        .background(Color.secondary)
        .cornerRadius(60)
        
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

