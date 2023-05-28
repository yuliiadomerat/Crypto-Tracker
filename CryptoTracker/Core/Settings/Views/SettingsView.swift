//
//  SettingsView.swift
//  CryptoTracker
//
//  Created by Yuliia on 24.05.23.
//

import SwiftUI

struct SettingsView: View {
    let coinGetckoURL = URL(string: "https://www.coingecko.com")!
    let termsOfService = URL(string: "https://developer.apple.com/help/app-store-connect/" )!
    let privacyPolicy = URL(string: "https://developer.apple.com/help/app-store-connect/")!
    var body: some View {
            NavigationView{
                ZStack{
                    Color.theme.background.ignoresSafeArea()
                    
                    ScrollView{
                        VStack(spacing: 40){
                            appInfo
                            coinGetckoInfo
                            termsOfUseInfo
                        }
                        .padding()
                        .padding(.horizontal)
                        .navigationTitle("Settings")
                        .toolbar{
                            ToolbarItem(placement: .navigationBarLeading) {
                                XMarkButton()
                            }
                        }
                    }
            }
        }
        
        }
    }

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}

extension SettingsView {
    
    private var appInfo: some View {
        VStack(spacing: 20){
            Text("About App")
                .foregroundColor(Color.theme.accent)
                .bold()
                .font(.headline)
            
            
            Text("Introducing the Crypto Tracker App for iOS. Track crypto asset prices, manage portfolios, and enjoy a sleek neomorphic design. With light and dark modes, CoinGecko API integration, and utilizing MVVM, Combine, Core Data, and SwiftUl, it's the ultimate tool for monitoring and managing your cryptocurrency investments. The project benefits from multi-threading, publishers/subscribers, and data persistence, ensuring a seamless and efficient user experience.")
            
                .foregroundColor(Color.theme.secondaryText)
                .font(.callout)
                .multilineTextAlignment(.center)
            
        }
        .padding()
        .modifier(customNeuromorphicBackground(cornerRadius: 10, neuromorphicShadow: true))
    }
    private var coinGetckoInfo: some View {
        VStack(spacing: 20){
            Text("CoinGecko API")
                .foregroundColor(Color.theme.accent)
                .bold()
                .font(.headline)
            
            
            Text("CoinGecko API, launched in 2014, is the largest independent crypto data aggregator. With 10-30 calls/minute rate limit, it offers comprehensive and reliable RESTful JSON endpoints for obtaining price feeds, market data, metadata, and historical information on 10,000+ coins, exchanges, and NFTs. Trusted by projects, developers, institutions worldwide.")
                .foregroundColor(Color.theme.secondaryText)
                .font(.callout)
                .lineLimit(nil)
                .multilineTextAlignment(.center)
            
            Link("CoinGecko", destination: coinGetckoURL)
                .foregroundColor(Color.theme.secondaryText)
        }
        .padding()
        .modifier(customNeuromorphicBackground(cornerRadius: 10, neuromorphicShadow: true))
        
    }
    private var termsOfUseInfo: some View {
        HStack(){
            Link("Terms of Service", destination: termsOfService)
                .font(.footnote)
                .foregroundColor(Color.theme.secondaryText)
            
            Link("PrivacyPolicy", destination: privacyPolicy)
                .font(.footnote)
                .foregroundColor(Color.theme.secondaryText)
        }
    }
}
