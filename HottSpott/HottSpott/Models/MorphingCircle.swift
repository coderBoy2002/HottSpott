//
//  MorphingCircle.swift
//  HottSpott
//
//  Created by Patrick Hutecker on 3/24/24.
//

import Foundation
import SwiftUI

struct MorphingCircle: View & Identifiable & Hashable {
    // ANIMATION VAR
    let duration: Double
    let points: Int
    let secting: Double
    let size: CGFloat
    let outerSize: CGFloat
    var color: Color
    let morphingRange: CGFloat
    
    // DIMENSION VAR
    let imageOffsets: [CGPoint]
    let screenWidth: CGFloat
    let screenHeight: CGFloat
    var radius: CGFloat {
        outerSize / 2
    }
    
    // INEXCLIPABLE VAR
    let id = UUID()
    @State var morph: AnimatableVector = AnimatableVector.zero
    @State var timer: Timer?

    
    var body: some View {

        // TODO LEARN THIS TIMER NONSENSE
        MorphingCircleShape(morph)
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
    
    init(_ size:CGFloat = 300, morphingRange: CGFloat = 30, color: Color = .red, points: Int = 4,  duration: Double = 5.0, secting: Double = 2, imageOffsets: [CGPoint], screenWidth: CGFloat, screenHeight: CGFloat) {
        self.points = points
        self.color = color
        self.morphingRange = morphingRange
        self.duration = duration
        self.secting = secting
        self.size = morphingRange * 2 < size ? size - morphingRange * 2 : 5
        self.outerSize = size
        morph = AnimatableVector(values: [])
        
        self.imageOffsets = imageOffsets
        self.screenWidth = screenWidth
        self.screenHeight = screenHeight
        
        update()
    }
    
    func color(_ newColor: Color) -> MorphingCircle {
        var morphNew = self
        morphNew.color = newColor
        return morphNew
    }
    
    static func == (lhs: MorphingCircle, rhs: MorphingCircle) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

extension MorphingCircle {
    
    func morphCreator() -> AnimatableVector {
        //let range = Float(-morphingRange)...Float(morphingRange)
        let sudoRadius = min(screenWidth / 2, screenHeight / 2) * 1.5
        var morphing = Array.init(repeating: Float.zero, count: self.points)
        
        for i in 0..<self.points where Int.random(in: 0...1) == 0 {
            let xRandom = Float((imageOffsets[i].x - screenWidth / 2) / sudoRadius)
            let yRandom = Float((imageOffsets[i].y - screenHeight / 2) / sudoRadius)
            let xFact = Float(i / self.points)
            let yFact = Float(1.0 - xFact)
            let shuffleRandom = xRandom * xFact + yRandom * yFact
            morphing[i] = morphingRange * shuffleRandom
        }
        return AnimatableVector(values: morphing)
    }
    
    func update() {
        morph = morphCreator()
    }
}
