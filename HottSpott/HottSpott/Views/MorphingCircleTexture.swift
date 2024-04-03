//
//  MorphingCircleTexture.swift
//  HottSpott
//
//  Created by Patrick Hutecker on 3/26/24.
//

import SwiftUI

struct MorphingCircleTexture: View {
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    
    @State var color: Color
    @State var speed: Double
    @State var onlyBottom: Bool
    
    init (color: Color, speed: Double, onlyBottom: Bool) {
        self.color = color
        self.speed = speed
        self.onlyBottom = onlyBottom
    }
    
    var body: some View {
        ZStack {
            bottomLayer
                .opacity(0.2)
            
            if !onlyBottom {
                middleLayer
                    .opacity(0.3)
            }
        }
    }
    
}


#Preview {
    MorphingCircleTexture(color: Color.red, speed: 0.5, onlyBottom: false)
}
 

extension MorphingCircleTexture {

    
    private func getLayerOfTexture(size: CGFloat,
                                   numCircles: Int,
                                   morphingRange: CGFloat,
                                   points: Int,
                                   duration: Double,
                                   secting: Double) -> some View {
        
        return MorphingCircleGroup(
                    size: size,
                    morphingRange: morphingRange,
                    color: color,
                    points: points,
                    duration: duration,
                    secting: secting,
                    screenWidth: screenWidth,
                    screenHeight: screenHeight,
                    numCircles: numCircles
                )
    }
    
    private var bottomLayer: some View {
        return getLayerOfTexture(size: 1500,
                                 numCircles: 3,
                                 morphingRange: 400,
                                 points: 3,
                                 duration: 10.0 * speed,
                                 secting: 0.9)
    }
    
    private var middleLayer: some View {
        return getLayerOfTexture(size: 1100,
                                 numCircles: 5,
                                 morphingRange: 300,
                                 points: 4,
                                 duration: 10.0 * speed,
                                 secting: 0.9)
    }
}


