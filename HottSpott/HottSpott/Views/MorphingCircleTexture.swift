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
    
    private func getPartitions(numCircles: Int, size: CGFloat) -> [CGPoint] {
        var imageOffsets: [CGPoint] = Array(repeating: CGPoint.zero, count: numCircles)
        
        for index in 0..<numCircles {
            let sudoRadius = min(screenWidth / 2, screenHeight / 2) * 1.5
            let ranR = CGFloat(Double.random(in: 0..<sudoRadius))
            
            let ranCos = CGFloat(Double.random(in: -1.0..<1.0))
            let ranSin = sqrt(1 - (ranCos * ranCos))
            
            let xRandom = ranR * ranCos + screenWidth / 2
            let yRandom = ranR * ranSin + screenHeight / 2
            
            imageOffsets[index] = CGPoint(
                x: xRandom,
                y: yRandom
            )
        }
        return imageOffsets
    }
    
    private func getLayerOfTexture(size: CGFloat,
                                   numCircles: Int,
                                   morphingRange: CGFloat,
                                   points: Int,
                                   duration: Double,
                                   secting: Double) -> some View {
        
        
        // CREATES OFFSETS FOR EACH MORPHING CIRCLE
        let imageOffsets = getPartitions(numCircles: numCircles,
                                               size: size)
        
        
        
        return MorphingCircleGroup(
                    size: size,
                    numCircles: numCircles,
                    morphingRange: morphingRange,
                    points: points,
                    duration: duration,
                    secting: secting,
                    color: color,
                    imageOffsets: imageOffsets
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


