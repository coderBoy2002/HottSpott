//
//  MorphingCircleTexture.swift
//  HottSpott
//
//  Created by Patrick Hutecker on 3/26/24.
//

import SwiftUI

struct MorphingCircleTexture: View {
    
    @State var color: Color
    @State private var imageOffsets: [CGPoint] = Array(repeating: CGPoint.zero, count: 200)
    @State private var showingOverlay = true
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    
    var body: some View {
        ZStack {
            ForEach(0..<200) { index in
                MorphingCircle(100, morphingRange: 30, color: color, points: 4,  duration: 5.0, secting: 2)
                    .position(
                        x: imageOffsets[index].x,
                        y: imageOffsets[index].y
                    )
            }
        }
        .ignoresSafeArea()
        .onAppear {
            for index in 0..<200 {
                imageOffsets[index] = CGPoint(x: .random(in: 0..<screenWidth), y: .random(in: 0..<screenHeight))
            }
        }
        .overlay {
            if showingOverlay {
                OverlayView(imageOffsets: imageOffsets, color: color)
            }
        }
    }
}
struct OverlayView: View {
    let imageOffsets: [CGPoint]
    let color: Color
    
    var body: some View {
        ZStack {
            Color.clear
            ForEach(0..<200) { index in
                MorphingCircle(100, morphingRange: 30, color: color, points: 4,  duration: 5.0, secting: 2)
                    .position(
                        x: imageOffsets[index].x,
                        y: imageOffsets[index].y
                    )
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    MorphingCircleTexture(color: Color.blue)
}
