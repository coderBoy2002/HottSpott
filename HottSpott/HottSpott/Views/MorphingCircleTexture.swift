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
    @State var color: Color
    @State private var imageOffsets: [CGPoint]
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    
    let morphingRange: CGFloat = 30
    let points: Int = 4
    let duration: Double = 5.0
    let secting: Double = 2
    
    init(size: CGFloat, numCircles: Int, color: Color) {
        self.size = size
        self.numCircles = numCircles
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
    MorphingCircleTexture(size: 120, numCircles: 10, color: Color.blue)
}
