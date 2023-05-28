//
//  DetailView.swift
//  CryptoTracker
//
//  Created by Yuliia on 17.05.23.
//

import SwiftUI


struct DetailLoadingView: View {
    @Binding var coin: CoinModel?
    var body: some View {
        ZStack{
            if let coin = coin {
                DetailView(coin: coin)
            }
        }
    }
}

struct DetailView: View {
    
    @StateObject var vm: DetailViewModel
    @State private var showFullDescription: Bool = false
    private let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    private let spacing: CGFloat = 30
    
    init(coin:CoinModel){
        _vm = StateObject(wrappedValue: DetailViewModel(coin: coin))
        print("Initializing Detail View for \(coin.name)")
    }
    var body: some View {
        ScrollView{
            VStack{
                Spacer()
                ChartView(coin: vm.coin)
                .padding()
                VStack(spacing: 20){
                    overviewTitle
                    Divider()
                    descriptionText
                    overviewGrid
                    additionalTitle
                    Divider()
                    additionalGrid
                    websiteLinks
                }
            }
        }
        .padding()
        .background(Color.theme.background)
        .navigationTitle(vm.coin.name)
        .toolbar{
            ToolbarItem(placement: .navigationBarTrailing) {
                navigationBarTitle
                
            }
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            DetailView(coin: dev.coin)
        }
       // .preferredColorScheme(.dark)
    }
}

extension DetailView {
    
    private var descriptionText: some View {
        ZStack{
            if let coinDescription = vm.coinDescription,
               !coinDescription.isEmpty {
                VStack(){
                    Text(coinDescription)
                        .lineLimit(showFullDescription ? nil : 3)
                        .font(.callout)
                        .foregroundColor(Color.theme.secondaryText)
                    Button {
                        showFullDescription.toggle()
                    } label: {
                        Text( showFullDescription ?   "Read less" : "Read more ...")
                            .font(.callout)
                            .foregroundColor(Color.theme.secondaryText)
                    }
                }
            }
        }
        .padding()
        .modifier(customNeuromorphicBackground(cornerRadius: 10, neuromorphicShadow: true))
        .padding()
    }
    
    private var navigationBarTitle: some View{
        HStack{
            Text(vm.coin.symbol.uppercased())
                .font(.headline)
                .foregroundColor(Color.theme.secondaryText)
            CoinImageView(coin: vm.coin)
                .frame(width: 25, height: 25)
        }
    }
    private var overviewTitle: some View {
        Text("Overview")
            .font(.title)
            .bold()
            .foregroundColor(Color.theme.accent)
            .frame(maxWidth: .infinity, alignment: .leading)
        
    }
    
    private var additionalTitle: some View {
        Text("Additinal Details")
            .font(.title)
            .bold()
            .foregroundColor(Color.theme.accent)
            .frame(maxWidth: .infinity, alignment: .leading)
        
    }
    
    private var overviewGrid: some View {
       
        LazyVGrid(
            columns: columns,
            alignment: .leading,
            spacing: spacing,
            pinnedViews: [])
        {
            ForEach(vm.overviewStatistics) { stat in
                StatisticView(cornerRadius: 10, neuromorphicEffect: false, stat: stat)
            }
        }
        .modifier(customNeuromorphicBackground(cornerRadius: 10, neuromorphicShadow: true))
        .padding()
    }
    
    private var additionalGrid: some View {
     
            LazyVGrid(
                columns: columns,
                alignment: .leading,
                spacing: spacing,
                pinnedViews: [])
            {
                ForEach(vm.additionalStatistics) { stat in
                    StatisticView(cornerRadius: 10, neuromorphicEffect: false, stat: stat)
                }
            }
            .modifier(customNeuromorphicBackground(cornerRadius: 10, neuromorphicShadow: true))
            .padding()
    }
    

    private var websiteLinks: some View{
        
        HStack(){
            if let websiteString = vm.websiteURL,
               let url = URL(string: websiteString){
              Link("Website", destination: url)
                    .padding()
                    .foregroundColor(Color.theme.secondaryText)
            }
               
            Spacer()
            if let redditString = vm.redditURL,
               let redditUrl = URL(string: redditString){
                Link("Reddit", destination: redditUrl)
                    .padding()
                    .foregroundColor(Color.theme.secondaryText)
            }
            
        }
        .padding(.horizontal, 30)
        .padding(.vertical, -10)
    }
    
}
