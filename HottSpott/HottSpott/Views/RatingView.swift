//
//  RatingView.swift
//  HottSpott
//
//  Created by Patrick Hutecker on 3/24/24.
//

import SwiftUI

struct RatingView: View {
    
    @State var ratingLineHeight: CGFloat = UIScreen.main.bounds.height / 2
    
    let baseSize: CGFloat = 40
    @State var stretchOfConfirm: CGFloat = 40
    
    var body: some View {
        ZStack {
            temperatureSlider
            confirmRating
        }
    }
}

#Preview {
    RatingView()
}

extension RatingView {
    private var temperatureSlider: some View {
        VStack {
            RoundedRectangle(cornerRadius: 15)
                       .fill(.red)
                       .ignoresSafeArea()
                       .frame(height: ratingLineHeight)
            RoundedRectangle(cornerRadius: 15)
                       .fill(.blue)
                       .ignoresSafeArea()
                       .frame(height: UIScreen.main.bounds.height - ratingLineHeight)
        }
        .opacity(0.6)
        .gesture(
            DragGesture()
                .onChanged { gesture in
                    ratingLineHeight = gesture.location.y
                }
                .onEnded { gesture in
                    ratingLineHeight = gesture.location.y
                }
        )
    }
    
    private var confirmRating: some View {
        Image(systemName: "circle.circle.fill")
              .foregroundStyle(.primary, .secondary)
              .font(.system(size: stretchOfConfirm))
              .padding(4)
              .background(.ultraThinMaterial)
              .cornerRadius(20)
              .border(Color.accentColor, width: stretchOfConfirm - baseSize)
              .cornerRadius(20)
              .offset(y:UIScreen.main.bounds.height / 2.4)
              .gesture(
                DragGesture()
                    .onChanged { gesture in
                        stretchOfConfirm = gesture.translation.width * 0.1 + baseSize
                    }
                    .onEnded { gesture in
                        stretchOfConfirm = baseSize
                    }
              )
    }
}
