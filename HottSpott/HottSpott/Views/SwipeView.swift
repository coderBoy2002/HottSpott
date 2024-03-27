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
    let screenWidth: CGFloat = UIScreen.main.bounds.width

    var body: some View {
        ZStack {
            mainPreview(location: vm.mapLocation)
                .offset(x: vm.swipeAmount)
                .gesture(
                    DragGesture()
                        .onChanged { gesture in
                            /*if vm.setSwipeFactor &&
                                !vm.hasSetSwipeFactor {
                                let curX: CGFloat = gesture.location.x
                                print(curX)
                                print(vm.startX)
                                print(screenWidth / 2)
                                if curX >=  vm.startX && curX > screenWidth / 2  {
                                    vm.swipeFactor += (screenWidth/2)/(screenWidth - curX)
                                }
                                else if curX < vm.startX && curX < screenWidth / 2 {
                                    vm.swipeFactor += (screenWidth/2)/curX
                                }
                                print(vm.swipeFactor)
                                vm.hasSetSwipeFactor = true
                                
                            }*/
                            if vm.startX != -100 {
                                let curX: CGFloat = gesture.location.x
                                if  curX >  vm.startX {
                                    if curX > screenWidth / 2 {
                                        vm.swipeAmount = vm.swipeFactor * ( curX - max(screenWidth / 2,vm.startX))
                                        print(vm.swipeAmount)
                                    }
                                }
                                else if curX < screenWidth / 2 {
                                    vm.swipeAmount = vm.swipeFactor * (curX - min(screenWidth / 2,vm.startX))
                                }
                                
                            }
                            else {
                                vm.swipeFactor = 2.2
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
