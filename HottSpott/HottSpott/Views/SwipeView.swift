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
    let totalSwipe: CGFloat = 300

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
                                    if curX > UIScreen.main.bounds.width / 2 {
                                        vm.swipeAmount = vm.swipeFactor * ( curX - max(UIScreen.main.bounds.width / 2,vm.startX))
                                        
                                    }
                                }
                                else if curX < UIScreen.main.bounds.width / 2 {
                                    vm.swipeAmount = vm.swipeFactor * (curX - min(UIScreen.main.bounds.width / 2,vm.startX))
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
                    .offset(x: -UIScreen.main.bounds.width+vm.swipeAmount)
            }
            else if vm.swipeAmount < -minPaddingForSwipe {
                mainPreview(location: vm.nextLocation)
                    .offset(x:UIScreen.main.bounds.width+vm.swipeAmount)
            }
        }
    }
}

#Preview {
    SwipeView()
        .environmentObject(LocationsViewModel())
}
