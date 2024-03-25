//
//  RatingView.swift
//  HottSpott
//
//  Created by Patrick Hutecker on 3/24/24.
//

import SwiftUI

struct RatingView: View {
    
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
}

extension RatingView {
    private var temperatureSlider: some View {
        VStack {
            RoundedRectangle(cornerRadius: stretchOfTemperature)
                       .fill(.red)
                       .ignoresSafeArea()
                       .frame(height: ratingLineHeight)
            RoundedRectangle(cornerRadius: stretchOfTemperature)
                       .fill(.blue)
                       .ignoresSafeArea()
                       .frame(height: UIScreen.main.bounds.height - ratingLineHeight)
        }
        .opacity(0.6)
        .gesture(
            DragGesture()
                .onChanged { gesture in
                    if isMovingScale {
                        ratingLineHeight = gesture.location.y
                        if ratingLineHeight < spacingFactor {
                            ratingLineHeight = spacingFactor
                        }
                        else if ratingLineHeight > UIScreen.main.bounds.height - spacingFactor {
                            ratingLineHeight = UIScreen.main.bounds.height - spacingFactor
                        }
                    }
                    else {
                        if (gesture.location.y - ratingLineHeight) < 20 {
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
                            stretchOfConfirm = gesture.translation.width * 0.1 + baseSizeConfirm
                            
                            stretchOfTemperature = baseSizeTemperature - 2.5 * gesture.translation.width
                            if stretchOfTemperature < 20 {
                                stretchOfTemperature = 20
                            }
                        
                    }
                    .onEnded {gesture in
                        stretchOfConfirm = baseSizeConfirm
                        stretchOfTemperature = baseSizeTemperature
                    }
              )
    }
}
