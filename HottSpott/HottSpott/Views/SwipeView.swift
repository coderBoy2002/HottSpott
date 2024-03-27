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
                                if  curX >  vm.startX {
                                    if curX > screenWidth / 2 {
                                        if vm.startX > screenWidth / 2 + swipeFactorAdjustment {
                                            vm.swipeFactor = 2.2 + 0.025*(abs(vm.startX - screenWidth/2 + swipeFactorAdjustment))
                                        }
                                        vm.swipeAmount = vm.swipeFactor * ( curX - max(screenWidth / 2,vm.startX))
                                    }
                                }
                                else if curX < screenWidth / 2 {
                                    if vm.startX < screenWidth / 2 - swipeFactorAdjustment {
                                        vm.swipeFactor = 2.2 + 0.025*(abs(screenWidth/2 - vm.startX - swipeFactorAdjustment))
                                    }
                                    
                                    vm.swipeAmount = vm.swipeFactor * (curX - min(screenWidth / 2,vm.startX))
                                }
                                
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
