//
//  MorphingCircleTexture.swift
//  HottSpott
//
//  Created by Patrick Hutecker on 3/26/24.
//

import SwiftUI

struct MorphingCircleTexture: View {
    
    @State var size: CGFloat
    @State var numCircles: Int
    @State var morphingRange: CGFloat
    @State var points: Int
    @State var duration: Double
    @State var secting: Double
    @State var color: Color
    @State private var imageOffsets: [CGPoint]
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    
    init(size: CGFloat, numCircles: Int, morphingRange: CGFloat, points: Int, duration: Double, secting: Double, color: Color) {
        self.size = size
        self.numCircles = numCircles
        self.morphingRange = morphingRange
        self.points = points
        self.duration = duration
        self.secting = secting
        self.color = color
        self.imageOffsets = Array(repeating: CGPoint.zero, count: numCircles)
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
        .onAppear {
            for index in 0..<numCircles {
                imageOffsets[index] = CGPoint(x: .random(in: 0..<screenWidth), y: .random(in: 0..<screenHeight))
            }
        }
    }
}

#Preview {
    MorphingCircleTexture(size: 100, numCircles: 70, morphingRange: 30, points: 10, duration: 5.0, secting: 2, color: Color.blue)
}
