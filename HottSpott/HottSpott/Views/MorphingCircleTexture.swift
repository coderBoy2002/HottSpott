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
    
    init (color: Color) {
        self.color = color
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(color)
                .ignoresSafeArea()
                .opacity(0.4)
            bottomLayer
                .opacity(0.3)
            middleLayer
                .opacity(0.3)
            topLayer
                .opacity(0.3)
            
        }
    }
    
}


#Preview {
    MorphingCircleTexture(color: Color.blue)
}
 

extension MorphingCircleTexture {
    
    private func getPartitions(numCircles: Int, percentOffset: Double) -> [CGPoint] {
        var imageOffsets: [CGPoint] = Array(repeating: CGPoint.zero, count: numCircles)
        
        let stepSize: CGFloat = screenHeight / CGFloat(numCircles)
        var lastX: CGFloat = 0.0
        var lastXSecond: CGFloat = 0.0
        for index in 0..<numCircles {
            var xRandom: CGFloat = .random(in: 0..<screenWidth)
            while abs(lastX - xRandom) < 100  && abs(lastXSecond - xRandom) < 100 {
                xRandom = .random(in: 0..<screenWidth)
            }
            lastXSecond = lastX
            lastX = xRandom
            
            
            let yRandomOffset = CGFloat(index) * stepSize * (1.0 - percentOffset + Double.random(in: 0.0...(2.0 * percentOffset)))
            let yRandom = (stepSize / 2) + yRandomOffset
            imageOffsets[index] = CGPoint(
                x: xRandom,
                y: yRandom
            )
        }
        return imageOffsets
    }
    
    
    private var sizeBottom: CGFloat {
        700
    }
    private var numCirclesBottom: Int {
        4
    }
    private var morphingRangeBottom: CGFloat {
        100
    }
    private var pointsBottom: Int {
        8
    }
    private var durationBottom: Double {
        20.0
    }
    private var sectingBottom: Double {
        100
    }
    private var imageOffsetsBottom: [CGPoint] {
        return getPartitions(numCircles: numCirclesBottom, percentOffset: 0.05)
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
        200
    }
    private var numCirclesMiddle: Int {
        10
    }
    private var morphingRangeMiddle: CGFloat {
        30
    }
    private var pointsMiddle: Int {
        7
    }
    private var durationMiddle: Double {
        7.0
    }
    private var sectingMiddle: Double {
        7
    }
    private var imageOffsetsMiddle: [CGPoint] {
        return getPartitions(numCircles: numCirclesMiddle, percentOffset: 0.05)
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
    
    private var sizeTop: CGFloat {
        150
    }
    private var numCirclesTop: Int {
        20
    }
    private var morphingRangeTop: CGFloat {
        20
    }
    private var pointsTop: Int {
        5
    }
    private var durationTop: Double {
        7.0
    }
    private var sectingTop: Double {
        5
    }
    private var imageOffsetsTop: [CGPoint] {
        return getPartitions(numCircles: numCirclesTop, percentOffset: 0.1)
    }
    
    private var topLayer: some View {
        return MorphingCircleGroup(
                    size: sizeTop,
                    numCircles: numCirclesTop,
                    morphingRange: morphingRangeTop,
                    points: pointsTop,
                    duration: durationTop,
                    secting: sectingTop,
                    color: color,
                    imageOffsets: imageOffsetsTop
                )
    }
}


