//
//  CircleButtonView.swift
//  CryptoTracker
//
//  Created by Yuliia on 27.04.23.
//

import SwiftUI

struct CircleButtonView: View {
    let rotation : Bool
    let iconName: String
    
    var body: some View {
        ZStack{
            Image(systemName: iconName)
                .font(.headline)
                .foregroundColor(Color.theme.accent)
                .frame(width: 50, height: 50)
                .background(shadowEffect)
        }
        .padding()
        
        
    }
}

struct CircleButtonView_Previews: PreviewProvider {
    static var previews: some View {
        
        Group{
            
            CircleButtonView(rotation: true, iconName: "info")
                .previewLayout(.sizeThatFits)
            
            CircleButtonView(rotation: false, iconName: "plus")
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.dark)
        }
       
    }
}

extension CircleButtonView {
    
    private var shadowEffect: some View {
        ZStack{
            Circle()
                .shadow(
                    color: Color.theme.shadowLight.opacity(0.8),
                    radius: 12,
                    x: rotation ? 6 : -6 ,
                    y: rotation ?  8 : -8)
                .shadow(
                    color: Color.theme.shadowDark,
                    radius: 12,
                    x: rotation ? -6 : 6 ,
                    y: rotation ? -8: 8)
                .blendMode(.overlay)
                .padding(2)
            
            Circle()
                .foregroundColor(Color.theme.background)
                .overlay(Circle()
                    .stroke(Color.theme.shadowOverlay.opacity(0.3),lineWidth: 1 ))
        }
    }
    
}
