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
    
    let baseSizeConfirm: CGFloat = 40
    let baseSizeTemperature: CGFloat = 250
    @State var stretchOfConfirm: CGFloat = 40
    @State var stretchOfTemperature: CGFloat = 250
    @State var isMovingScale: Bool = false
    
    let spacingFactor : CGFloat = 75
    
    var body: some View {
        ZStack {
            temperatureSlider
            confirmRating
        }
    }
}

#Preview {
    RatingView()
        .environmentObject(LocationsViewModel())
}

extension RatingView {
    private var temperatureSlider: some View {
        ZStack {
            MorphingCircleTexture(color: Color.gray, speed: 2.0, onlyBottom: true)
                .ignoresSafeArea()
                .opacity(0.6)
            VStack {
                MorphingCircleTexture(color: Color.blue, speed: 2.0, onlyBottom: false)
                    .ignoresSafeArea()
                    .offset(y: -screenHeight + ratingLineHeight)
                MorphingCircleTexture(color: Color.red, speed: 0.5, onlyBottom: false)
                    .ignoresSafeArea()
                    .offset(y: -screenHeight/2 + ratingLineHeight)
        }
        }
        .gesture(
            DragGesture()
                .onChanged { gesture in
                    if isMovingScale {
                        ratingLineHeight = gesture.location.y
                        if ratingLineHeight < spacingFactor {
                            ratingLineHeight = spacingFactor
                        }
                        else if ratingLineHeight > screenHeight - spacingFactor {
                            ratingLineHeight = screenHeight - spacingFactor
                        }
                    }
                    else {
                        if abs(gesture.location.y - ratingLineHeight) < 60 {
                            isMovingScale = true
                        }
                    }
                        
                }
                .onEnded { gesture in
                    isMovingScale = false
                }
        )
    }
    
    private var confirmRating: some View {
        Image(systemName: "circle.circle.fill")
              .foregroundStyle(.primary, .secondary)
              .font(.system(size: stretchOfConfirm))
              .padding(4)
              .background(.ultraThinMaterial)
              .cornerRadius(20)
              .border(Color.accentColor, width: stretchOfConfirm - baseSizeConfirm)
              .cornerRadius(20)
              .offset(y:UIScreen.main.bounds.height / 2.4)
              .gesture(
                DragGesture()
                    .onChanged { gesture in
                        
                            let distance_calc = sqrt(pow(gesture.translation.width ,2) + pow(gesture.translation.height, 2))
                            stretchOfConfirm = distance_calc * 0.1 + baseSizeConfirm
                            
                            stretchOfTemperature = baseSizeTemperature - 3 * distance_calc
                            if stretchOfTemperature < 20 {
                                stretchOfTemperature = 20
                            }
                        
                    }
                    .onEnded {gesture in
                        
                        if stretchOfTemperature == 20 {
                            vm.confirmedRating = true
                        }
                        stretchOfConfirm = baseSizeConfirm
                        stretchOfTemperature = baseSizeTemperature
                    }
              )
    }
}
