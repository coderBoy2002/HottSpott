//
//  MorphingCircle.swift
//  HottSpott
//
//  Created by Patrick Hutecker on 3/24/24.
//

import Foundation
import SwiftUI

struct MorphingCircleGroup: View & Identifiable & Hashable {
    // ANIMATION VAR
    let duration: Double
    let points: Int
    let secting: Double
    let size: CGFloat
    let outerSize: CGFloat
    var color: Color
    let morphingRange: CGFloat
    
    // DIMENSION VAR
    let screenWidth: CGFloat
    let screenHeight: CGFloat
    var radius: CGFloat {
        outerSize / 2
    }
    let numCircles: Int
    
    // INEXCLIPABLE VAR
    let id = UUID()
    
    @State var timer: Timer?

    @State var imageOffsets: [CGPoint]
    @State var morphs: [AnimatableVector]
    
    var body: some View {
        // TODO LEARN THIS TIMER NONSENSE
        ZStack {
            ForEach(0..<numCircles) { index in
                basicView(index: index)
                    .position(
                        x: imageOffsets[index].x,
                        y: imageOffsets[index].y
                    )
                
            }
        }
        .ignoresSafeArea()
        
        
    }
    
    init(size:CGFloat,
         morphingRange: CGFloat,
         color: Color,
         points: Int,
         duration: Double,
         secting: Double,
         screenWidth: CGFloat,
         screenHeight: CGFloat,
         numCircles: Int) {
        self.points = points
        self.color = color
        self.morphingRange = morphingRange
        self.duration = duration
        self.secting = secting
        self.size = morphingRange * 2 < size ? size - morphingRange * 2 : 5
        self.outerSize = size
        
        self.imageOffsets = Array.init(repeating: CGPoint.zero,
                                       count: numCircles)
        
        self.screenWidth = screenWidth
        self.screenHeight = screenHeight
        
        self.numCircles = numCircles
        
        self.morphs = Array.init(repeating: AnimatableVector.zero,
                                         count: numCircles)
        
        update()
    }
    
    func color(_ newColor: Color) -> MorphingCircleGroup {
        var morphNew = self
        morphNew.color = newColor
        return morphNew
    }
    
    static func == (lhs: MorphingCircleGroup, rhs: MorphingCircleGroup) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
}

extension MorphingCircleGroup {
    
    private func basicView(index: Int) -> some View {
        var morph = morphs[index]
        return MorphingCircleShape(morph)
            .fill(color)
            .frame(width: size, height: size, alignment: .center)
            .animation(Animation.easeInOut(duration: Double(duration + 1.0)), value: morph)
            .onAppear {
                update()
                timer = Timer.scheduledTimer(withTimeInterval: duration / secting, repeats: true) { timer in
                    update()
                }
            }
            .onDisappear {
                timer?.invalidate()
            }
            .frame(width: outerSize, height: outerSize, alignment: .center)
            .animation(nil, value: morph)
    }
    
    func morphCreator(j: Int) -> AnimatableVector {
        //let range = Float(-morphingRange)...Float(morphingRange)
        let sudoRadius = min(screenWidth / 2, screenHeight / 2) * 1.5
        let numPoints = self.points
        var morphing = Array.init(repeating: Float.zero, count: numPoints)
        
        let curX = imageOffsets[j].x
        let curY = imageOffsets[j].y
        let xRandom = Float((curX - screenWidth / 2) / sudoRadius)
        let yRandom = Float((curY - screenHeight / 2) / sudoRadius)
        
        for i in 0..<numPoints{
            let xFact = Float(i - 1) / Float(numPoints)
            let yFact = 1.0 - Float(xFact)
            
            morphing[i] = Float(morphingRange) * (xRandom * xFact + yRandom * yFact)
        }
        return AnimatableVector(values: morphing)
    }
    
    func update() {
        self.imageOffsets = getPartitions(numCircles: numCircles,
                                          size: size)
        for j in 0..<numCircles{
            morphs[j] = morphCreator(j: j)
        }
    }
        
        func getPartitions(numCircles: Int, size: CGFloat) -> [CGPoint] {
            var imageOffsetsTemp: [CGPoint] = Array(repeating: CGPoint.zero, count: numCircles)
            
            let xRadius = screenWidth / 2
            let yRadius = screenHeight / 2
            
            for index in 0..<numCircles {
                let l = Double(index) / Double(numCircles)
                let u = Double(index + 1) / Double(numCircles)
                let ranFloat = Double.random(in: l..<u)
                let ranRadian = Double.random(in: 0.0..<2*Double.pi)
                let ranCos = cos(ranRadian)
                let ranSin = sin(ranRadian)
                
                let xRandom = xRadius * ranFloat * ranCos + screenWidth / 2
                let yRandom = yRadius * ranFloat * ranSin + screenHeight / 2
                
                imageOffsetsTemp[index] = CGPoint(
                    x: xRandom,
                    y: yRandom
                )
            }
            imageOffsetsTemp.shuffle()
            return imageOffsetsTemp
        }
}
