//
//  CryptoTrackerApp.swift
//  CryptoTracker
//
//  Created by Yuliia on 21.04.23.
//

import SwiftUI

@main
struct CryptoTrackerApp: App {
    
    @StateObject private var vm = HomeViewModel()
    @State private var showLaunchView: Bool = true
    
    init(){
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor(Color.theme.accent)]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor(Color.theme.accent)]
        UINavigationBar.appearance().backgroundColor = UIColor(Color.theme.background)
        UINavigationBar.appearance().barTintColor = UIColor(Color.theme.background)
       
    }
    
    
    var body: some Scene {
        WindowGroup {
            ZStack{
                NavigationView{
                    HomeView()
                        .navigationBarHidden(true)
                }
                .navigationViewStyle(StackNavigationViewStyle())
                .environmentObject(vm)
                
                ZStack{
                    if showLaunchView{
                        LaunchView(showLaunchScreen: $showLaunchView)
                            .transition(.move(edge: .leading))
                    }
                }
                .zIndex(2.0)
                
            }
        }
    }
}
