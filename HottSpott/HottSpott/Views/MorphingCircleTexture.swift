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
    
    private func getPartitions(numCircles: Int) -> [CGFloat] {
        let stepSize: CGFloat = screenHeight / CGFloat(numCircles)
        var imageOffsets: [CGPoint] = Array(repeating: CGPoint.zero, count: numCircles)
        for index in 0..<numCircles {
            imageOffsets[index] = CGPoint(
                x: .random(in: 0..<screenWidth),
                y:  stepSize / 2 + index * stepSize * (1 + .random(in: 0..<0.5))
            )
        }
        return imageOffsets
    }
    
    private var numCirclesBottom: Int {
        2
    }
    
    private var imageOffsetsBottom: [CGPoint] {
        return getPartitions(numCirclesBottom)
    }
    
    private var bottomLayer: some View {

        return MorphingCircleGroup(size: 500, numCircles: numCirclesBottom, morphingRange: 60, points: 8, duration: 5.0, secting: 2, color: color, imageOffsets: imageOffsetsBottom)
    }
}


