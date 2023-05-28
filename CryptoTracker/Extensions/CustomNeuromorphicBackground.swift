//
//  CustomNeuromorphicBackground.swift
//  CryptoTracker
//
//  Created by Yuliia on 26.05.23.
//

import Foundation
import SwiftUI

struct customNeuromorphicBackground: ViewModifier{
    
    let cornerRadius: CGFloat
    let neuromorphicShadow: Bool
    
    func body(content: Content) -> some View {
        
        if neuromorphicShadow {
            content
                .background(
                    ZStack{
                        // Shadow and Blending
                        RoundedRectangle(cornerRadius: cornerRadius)
                            .shadow(
                                color: Color.theme.shadowLight.opacity(0.8),
                                radius: 12,
                                x: -6 ,
                                y: -8)
                            .shadow(
                                color: Color.theme.shadowDark,
                                radius: 12,
                                x: 6 ,
                                y: 8)
                            .blendMode(.overlay)
                            .padding(2)
                        
                        // Background color and stroke
                        RoundedRectangle(cornerRadius: cornerRadius)
                            .foregroundColor(Color.theme.background)
                            .overlay(
                                RoundedRectangle(cornerRadius: cornerRadius)
                                .stroke(
                                    Color.theme.shadowOverlay.opacity(0.3),
                                    lineWidth: 1 ))
                    }
                )
        } else {
            content
                .background(RoundedRectangle(cornerRadius: cornerRadius)
                    .foregroundColor(Color.theme.background))
        }
    }
}
