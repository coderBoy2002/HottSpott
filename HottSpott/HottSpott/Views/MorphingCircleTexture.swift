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
                    .opacity(0.4)
            }
        }
    }
    
}


#Preview {
    MorphingCircleTexture(color: Color.red, speed: 1.2, onlyBottom: false)
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
        return getLayerOfTexture(size: 500,
                                 numCircles: 10,
                                 morphingRange: 100,
                                 points: 3,
                                 duration: 10.0 * speed,
                                 secting: 1.0)
    }
    
    private var middleLayer: some View {
        return getLayerOfTexture(size: 250,
                                 numCircles: 5,
                                 morphingRange: 50,
                                 points: 3,
                                 duration: 10.0 * speed,
                                 secting: 1.0)
    }
}


