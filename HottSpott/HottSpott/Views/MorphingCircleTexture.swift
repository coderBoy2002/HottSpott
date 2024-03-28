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
        bottomLayer
    }
    
}

#Preview {
    MorphingCircleTexture(color: Color.blue)
}

extension MorphingCircleTexture {
    private var numCirclesBottom: Int {
        2
    }
    private var imageOffsetsBottom: [CGPoint] {
        var imageOffsets: [CGPoint] = Array(repeating: CGPoint.zero, count: numCirclesBottom)
        for index in 0..<numCirclesBottom {
            imageOffsets[index] = CGPoint(
                x: .random(in: 0..<screenWidth),
                y: .random(in: 0..<screenHeight)
            )
        }
        return imageOffsets
    }
    private var bottomLayer: some View {

        return MorphingCircleGroup(size: 500, numCircles: numCirclesBottom, morphingRange: 60, points: 8, duration: 5.0, secting: 2, color: color, imageOffsets: imageOffsetsBottom)
    }
}


