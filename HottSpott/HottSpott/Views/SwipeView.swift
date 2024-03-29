//
//  SwipeView.swift
//  HottSpott
//
//  Created by Patrick Hutecker on 3/26/24.
//

import SwiftUI

struct SwipeView: View {
    
    @EnvironmentObject private var vm: LocationsViewModel
    
    private func mainPreview(location: Location) -> some View {
        return LocationPreviewView(location: location)
            .shadow(color: Color.black.opacity(0.3), radius: 20)
            .padding()
            .environmentObject(vm)
    }
    
    let minPaddingForSwipe: CGFloat = 0
    let screenWidth: CGFloat = UIScreen.main.bounds.width
    let swipeFactorAdjustment: CGFloat = 30

    var body: some View {
        ZStack {
            mainPreview(location: vm.mapLocation)
                .offset(x: vm.swipeAmount)
                .gesture(
                    DragGesture()
                        .onChanged { gesture in
                            if vm.startX != -100 {
                                let curX: CGFloat = gesture.location.x
                                vm.updateSwipe(curX: curX, 
                                               screenWidth: screenWidth,
                                               swipeFactorAdjustment: swipeFactorAdjustment)
                            }
                            else {
                                vm.startX = gesture.location.x
                            }
                        }
                        .onEnded { gesture in
                            vm.checkSwipeConditions()
                        }
                )
            if vm.swipeAmount > minPaddingForSwipe {
                mainPreview(location: vm.lastLocation)
                    .offset(x: -screenWidth+vm.swipeAmount)
            }
            else if vm.swipeAmount < -minPaddingForSwipe {
                mainPreview(location: vm.nextLocation)
                    .offset(x:screenWidth+vm.swipeAmount)
            }
        }
    }
}

#Preview {
    SwipeView()
        .environmentObject(LocationsViewModel())
}
