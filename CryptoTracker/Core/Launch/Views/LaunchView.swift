//
//  LaunchView.swift
//  CryptoTracker
//
//  Created by Yuliia on 26.05.23.
//

import SwiftUI

struct LaunchView: View {
    
    @State private var loadingText: [String] = "Loading ...".map{String($0)}
    @State private var showLoading: Bool = false
    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    @State private var counter: Int = 0
    @State private var loops: Int = 0
    @Binding var showLaunchScreen: Bool
    
    
    var body: some View {
        ZStack{
            Color.accent.launchBackground.ignoresSafeArea()
            
            Image("Logo")
                .resizable()
                .frame(width: 300, height: 300)
            
            ZStack{
                if showLoading {
                    HStack(spacing: 0){
                        ForEach(loadingText.indices, id: \.self) { index in
                            Text(loadingText[index])
                                .font(.headline)
                                .fontWeight(.medium)
                                .foregroundColor(Color.accent.launchText)
                                .offset(y: counter == index ? -3 : 0)
                        }
                    }
                    .transition(AnyTransition.scale.animation(.easeIn))
                }
            }
            .offset(y: 100)
        }
        .onAppear{
            showLoading.toggle()
        }
        .onReceive(timer, perform: { _ in
            withAnimation(.spring()){
                let lastIndex = loadingText.count - 1
                if counter == lastIndex {
                    counter = 0
                    loops += 1
                    if loops >= 2 {
                        showLaunchScreen = false
                    }
                } else {
                    counter += 1
                }
            }
        })
    }
}

struct LaunchView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView(showLaunchScreen: .constant(true))
    }
}
