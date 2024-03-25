//
//  MorphingCircle.swift
//  HottSpott
//
//  Created by Patrick Hutecker on 3/24/24.
//

import Foundation
import SwiftUI

struct MorphingCircle: View & Identifiable & Hashable {
    static func == (lhs: MorphingCircle, rhs: MorphingCircle) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    let id = UUID()
    @State var morph: AnimatableVector = AnimatableVector.zero
    @State var timer: Timer?
    
    func morphCreator() -> AnimatableVector {
        let range = Float(-morphingRange)...Float(morphingRange)
        var morphing = Array.init(repeating: Float.zero, count: self.points)
        for i in 0..<morphing.count where Int.random(in: 0...1) == 0 {
            morphing[i] = Float.random(in: range)
        }
        return AnimatableVector(values: morphing)
    }
    
    func update() {
        morph = morphCreator()
    }
    
    let duration: Double
    let points: Int
    let secting: Double
    let size: CGFloat
    let outerSize: CGFloat
    var color: Color
    let morphingRange: CGFloat
    
    var radius: CGFloat {
        outerSize / 2
    }
    
    var body: some View {
        MorphingCircleShape(morph)
            .fill(color)
            .frame(width: size, height: size, alignment: .center)
            .animation(Animation.easeInOut(duration: Double(duration + 1.0)), value: morph)
            .onAppear {
                update()
                timer = Timer.scheduledTimer(withTimeInterval: duration / secting, repeats: true) { timer in
                    update()
                }
            }.onDisappear {
                timer?.invalidate()
            }
            .frame(width: outerSize, height: outerSize, alignment: .center)
            .animation(nil, value: morph)
        
    }
    
    init(_ size:CGFloat = 300, morphingRange: CGFloat = 30, color: Color = .red, points: Int = 4,  duration: Double = 5.0, secting: Double = 2) {
        self.points = points
        self.color = color
        self.morphingRange = morphingRange
        self.duration = duration
        self.secting = secting
        self.size = morphingRange * 2 < size ? size - morphingRange * 2 : 5
        self.outerSize = size
        morph = AnimatableVector(values: [])
        update()
    }
    
    func color(_ newColor: Color) -> MorphingCircle {
        var morphNew = self
        morphNew.color = newColor
        return morphNew
    }
}


#Preview {
    MorphingCircle()
}
