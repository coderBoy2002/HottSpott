//
//  RatingView.swift
//  HottSpott
//
//  Created by Patrick Hutecker on 3/24/24.
//

import SwiftUI

struct RatingView: View {
    
    @EnvironmentObject private var vm: LocationsViewModel
    
    let screenHeight: CGFloat = UIScreen.main.bounds.height
    @State var ratingLineHeight: CGFloat = UIScreen.main.bounds.height / 2
    @State private var startY: CGFloat = -100
    @State private var startHeight: CGFloat = -100
    
    let spacingFactor : CGFloat = 75
    
    var body: some View {
        temperatureSlider
    }
}

#Preview {
    RatingView()
        .environmentObject(LocationsViewModel())
}

extension RatingView {
    private var temperatureSlider: some View {
        VStack {
            MorphingCircleTexture(color: Color.blue, speed: 0.5, onlyBottom: false)
                    .ignoresSafeArea()
                    .offset(y: screenHeight/2 * 0.4 - ratingLineHeight)
                    .rotationEffect(.degrees(-180))
            MorphingCircleTexture(color: Color.red, speed: 0.5, onlyBottom: false)
                    .ignoresSafeArea()
                    .offset(y: -screenHeight/2 * 1.6 + ratingLineHeight)
        }
        .gesture(
            DragGesture()
                .onChanged { gesture in
                    if startY != -100 {
                        let curHeight: CGFloat = gesture.location.y
                        ratingLineHeight = startHeight + 1.8 * (curHeight - startY)
                        if ratingLineHeight < spacingFactor {
                            ratingLineHeight = spacingFactor
                        }
                        else if ratingLineHeight > screenHeight - spacingFactor {
                            ratingLineHeight = screenHeight - spacingFactor
                        }
                    }
                    else {
                        startY = gesture.location.y
                        startHeight = ratingLineHeight
                        
                    }
                }
                .onEnded { gesture in
                    startY = -100
                    if ratingLineHeight == spacingFactor {
                        vm.confirmedRating = true
                    }
                    else if ratingLineHeight == screenHeight - spacingFactor {
                        vm.confirmedRating = true
                    }
                }
        )
    }
}
