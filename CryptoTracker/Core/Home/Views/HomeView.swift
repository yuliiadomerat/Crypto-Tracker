//
//  HomeView.swift
//  CryptoTracker
//
//  Created by Yuliia on 27.04.23.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject private var vm: HomeViewModel
    // Animating right
    @State private var  showPortfolio: Bool = false
    // New Sheet
    @State private var showPortfolioView: Bool = false
    @State private var showSettingsView: Bool = false
    
    
    @State private var selectedCoin: CoinModel? = nil
    @State private var showDetailView: Bool = false
    
    
    
    var body: some View {
        ZStack{
            //background layer
            Color.theme.background
                .ignoresSafeArea()
                .sheet(isPresented: $showPortfolioView, content: {
                    PortfolioView()
                        .environmentObject(vm)
                })
            
            // content layer
          
            VStack{
                homeHeader
                HomeStatsView(showPortfolio: $showPortfolio)
                SearchBarView(searchText: $vm.searchText)
                columnTitles
                
                if !showPortfolio{
                    allCoinsList
                    .transition(.move(edge: .leading))
                }
                if showPortfolio {
                    
                    ZStack(alignment: .top){
                        if vm.portfolioCoins.isEmpty && vm.searchText.isEmpty {
                            emptyPortfolioText
                            
                        } else {
                            portfolioCoinsList
                            
                        }
                }
                        .transition(.move(edge: .trailing))
                }
                Spacer(minLength: 0)
            }
            .sheet(isPresented: $showSettingsView) {
                SettingsView()
            }

        }
        .background(
                NavigationLink(
                destination: DetailLoadingView(coin: $selectedCoin),
                isActive: $showDetailView,
                label: {EmptyView()}
            )
        )
    }
}
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            HomeView()
                .navigationBarHidden(true)
        }
        .environmentObject(dev.homeVM)
         .preferredColorScheme(.dark)
    }
}

extension HomeView {
    
    private var homeHeader: some View{
        
        HStack{
            CircleButtonView(rotation: false, iconName: showPortfolio ? "plus" : "info")
                .animation(nil, value: showPortfolio)
                .onTapGesture {
                    if showPortfolio {
                        showPortfolioView.toggle()
                    }else {
                        showSettingsView.toggle()
                    }
                }
                .background(
                CircleButtonAnimatioView(animate: $showPortfolio)
                )
            Spacer()
            Text(showPortfolio ? "Portfolio" : "Live Prices")
                .font(.headline)
                .fontWeight(.heavy )
                .foregroundColor(Color.theme.accent)
            Spacer()
            CircleButtonView(rotation: showPortfolio, iconName:  "chevron.right" )
                .rotationEffect(Angle(degrees: showPortfolio ? 180 : 0))
                .onTapGesture {
                    withAnimation(.spring()) {
                        showPortfolio.toggle()
                    }
                }
            
        }
        .padding(.horizontal)
        
    }
    
    private var allCoinsList: some View {
   
        
        ScrollView{
            ForEach(vm.allCoins){ coin in
                CoinRowView(coin: coin, showHoldingsColumn: false)
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
                    .onTapGesture {
                        segue(coin: coin)
                    }
            }
            .modifier(customNeuromorphicBackground(cornerRadius: 25, neuromorphicShadow: true))
            .padding()
        }
        .listStyle(PlainListStyle())
        
    }
    
    private var portfolioCoinsList: some View {
        ScrollView{
            ForEach(vm.portfolioCoins){ coin in
                CoinRowView(coin: coin, showHoldingsColumn: true)
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
                    .onTapGesture {
                        segue(coin: coin)
                    }
            }
            .modifier(customNeuromorphicBackground(cornerRadius: 25, neuromorphicShadow: true))
            .padding()
        }
        .listStyle(PlainListStyle())
        
    }
    
    private var emptyPortfolioText: some View {
        Text("Click + button to add coins to your portfolio.")
            .foregroundColor(Color.theme.secondaryText)
            .font(.callout)
            .multilineTextAlignment(.center)
            .padding(50)
    }
    
    private func segue(coin: CoinModel){
        selectedCoin = coin
        showDetailView.toggle()
    }
    private var columnTitles: some View {
        
        HStack{
            HStack(spacing: 4){
                Spacer()
                Text("Coin")
                
                // Edit for the rotation effect 
                Image(systemName: "chevron.down")
                    .opacity((vm.sortOption == .rank || vm.sortOption == .rankReversed) ? 1.0 : 0.0)
                    .rotationEffect(Angle(degrees: vm.sortOption == .rank ? 0 : 180))
                Spacer()
            }
            .onTapGesture {
                withAnimation(.default){
                    vm.sortOption = vm.sortOption == .rank ? .rankReversed : .rank
                }
            }
            
            Spacer()
            if showPortfolio{
                HStack(spacing: 4){
                    Text("Holdings")
                    Image(systemName: "chevron.down")
                        .opacity((vm.sortOption == .holdings || vm.sortOption == .holdingsReversed) ? 1.0 : 0.0)
                        .rotationEffect(Angle(degrees: vm.sortOption == .holdings ? 0 : 180))
                }
                .onTapGesture {
                    withAnimation(.default){
                        vm.sortOption = vm.sortOption == .holdings ? .holdingsReversed : .holdings
                    }
                }
            }
            HStack(spacing: 4){
                Text("Price")
                Image(systemName: "chevron.down")
                    .opacity((vm.sortOption == .price || vm.sortOption == .priceReversed) ? 1.0 : 0.0)
                    .rotationEffect(Angle(degrees: vm.sortOption == .price ? 0 : 180))
            }
            .frame(width: UIScreen.main.bounds.width/3.5, alignment: .trailing)
                .onTapGesture {
                    withAnimation(.default){
                        vm.sortOption = vm.sortOption == .price ? .priceReversed : .price
                    }
                }

            Button {
                withAnimation(.linear(duration: 2.0)) {
                    vm.reloadData()
                }
            } label: {
                Image(systemName: "goforward")
            }
            .rotationEffect(Angle(degrees: vm.isLoading ? 360 : 0 ), anchor: .center)

        }
        .font(.caption)
        .foregroundColor(Color.theme.secondaryText)
        .padding(.horizontal)
    }
}

