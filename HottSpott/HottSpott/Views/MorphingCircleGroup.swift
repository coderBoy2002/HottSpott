//
//  MorphingCircleGroup.swift
//  HottSpott
//
//  Created by Patrick Hutecker on 3/28/24.
//

import SwiftUI

struct MorphingCircleGroup: View {
    @State var size: CGFloat
    @State var numCircles: Int
    @State var morphingRange: CGFloat
    @State var points: Int
    @State var duration: Double
    @State var secting: Double
    @State var color: Color
    @State var imageOffsets: [CGPoint]
    
    init(size: CGFloat, numCircles: Int, morphingRange: CGFloat, points: Int, duration: Double, secting: Double, color: Color, imageOffsets: [CGPoint]) {
        self.size = size
        self.numCircles = numCircles
        self.morphingRange = morphingRange
        self.points = points
        self.duration = duration
        self.secting = secting
        self.color = color
        self.imageOffsets = imageOffsets
    }
    
    var body: some View {
        ZStack {
            ForEach(0..<numCircles) { index in
                MorphingCircle(size, morphingRange: morphingRange, color: color, points: points,  duration: duration, secting: secting)
                    .position(
                        x: imageOffsets[index].x,
                        y: imageOffsets[index].y
                    )
            }
        }
        .ignoresSafeArea()
    }
}
