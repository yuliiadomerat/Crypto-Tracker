//
//  CircleButtonAnimatioView.swift
//  CryptoTracker
//
//  Created by Yuliia on 27.04.23.
//

import SwiftUI

struct CircleButtonAnimatioView: View {
    
    @Binding var animate: Bool
    
    var body: some View {
        Circle()
            .stroke(lineWidth: 5.0)
            .scale(animate ? 1.0 : 0.0)
            .opacity(animate ? 0.0 : 1.0)
            .animation(animate ? Animation.easeOut(duration: 1.0):
                       nil, value: UUID())
    }
}

struct CircleButtonAnimatioView_Previews: PreviewProvider {
    static var previews: some View {
        CircleButtonAnimatioView(animate: .constant(true))
            .foregroundColor(.red)
            .frame(width: 100, height: 100)
        
    }
}
