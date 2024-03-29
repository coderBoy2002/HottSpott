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
            /*RoundedRectangle(cornerRadius: 10)
                .fill(color)
                .ignoresSafeArea()
                .opacity(0.4)*/
            bottomLayer
                .opacity(0.2)
                .blur(radius: 6, opaque: false)
            
            if !onlyBottom {
                middleLayer
                    .opacity(0.3)
                    .blur(radius: 6, opaque: false)
            }
        }
    }
    
}


#Preview {
    MorphingCircleTexture(color: Color.red, speed: 0.5, onlyBottom: false)
}
 

extension MorphingCircleTexture {
    
    private func getPartitions(numCircles: Int, percentOffset: Double, size: CGFloat) -> [CGPoint] {
        var imageOffsets: [CGPoint] = Array(repeating: CGPoint.zero, count: numCircles)
        
        let stepSize: CGFloat = screenHeight / CGFloat(numCircles)
        var lastX: CGFloat = 0.0
        var lastXSecond: CGFloat = 0.0
        for index in 0..<numCircles {
            var xRandom: CGFloat = .random(in: 0..<screenWidth)
            while abs(lastX - xRandom) < 50  && abs(lastXSecond - xRandom) < 50 {
                xRandom = .random(in: 0..<screenWidth)
            }
            lastXSecond = lastX
            lastX = xRandom
            
            
            let yRandomOffset = CGFloat(index) * stepSize * (1.0 - percentOffset + Double.random(in: 0.0...(2.0 * percentOffset)))
            var yRandom = (stepSize / 2) + yRandomOffset
            if yRandom < 150 && size == 700 {
                yRandom = 150
            }
            
            
            imageOffsets[index] = CGPoint(
                x: xRandom,
                y: yRandom
            )
        }
        return imageOffsets
    }
    
    
    private var sizeBottom: CGFloat {
        1500
    }
    private var numCirclesBottom: Int {
        2
    }
    private var morphingRangeBottom: CGFloat {
        400
    }
    private var pointsBottom: Int {
        4
    }
    private var durationBottom: Double {
        10.0 * speed
    }
    private var sectingBottom: Double {
        8
    }
    private var imageOffsetsBottom: [CGPoint] {
        return getPartitions(numCircles: numCirclesBottom, percentOffset: 0.05, size: sizeBottom)
    }
    
    private var bottomLayer: some View {
        return MorphingCircleGroup(
                    size: sizeBottom,
                    numCircles: numCirclesBottom,
                    morphingRange: morphingRangeBottom,
                    points: pointsBottom,
                    duration: durationBottom,
                    secting: sectingBottom,
                    color: color,
                    imageOffsets: imageOffsetsBottom
                )
    }
    
    private var sizeMiddle: CGFloat {
        800
    }
    private var numCirclesMiddle: Int {
        10
    }
    private var morphingRangeMiddle: CGFloat {
        200
    }
    private var pointsMiddle: Int {
        4
    }
    private var durationMiddle: Double {
        10.0 * speed
    }
    private var sectingMiddle: Double {
        6
    }
    private var imageOffsetsMiddle: [CGPoint] {
        return getPartitions(numCircles: numCirclesMiddle, percentOffset: 0.05, size: sizeMiddle)
    }
    
    private var middleLayer: some View {
        return MorphingCircleGroup(
                    size: sizeMiddle,
                    numCircles: numCirclesMiddle,
                    morphingRange: morphingRangeMiddle,
                    points: pointsMiddle,
                    duration: durationMiddle,
                    secting: sectingMiddle,
                    color: color,
                    imageOffsets: imageOffsetsMiddle
                )
    }
}


