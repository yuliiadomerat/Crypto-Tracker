//
//  PortfolioView.swift
//  CryptoTracker
//
//  Created by Yuliia on 11.05.23.
//

import SwiftUI

struct PortfolioView: View {
    @EnvironmentObject private var vm: HomeViewModel
    @State private var selectedCoin: CoinModel? = nil
    @State private var quantityText: String = ""
    @State private var showCheckmark: Bool = false
    
    var body: some View {
        NavigationView{
            ZStack{
                Color.theme.background.ignoresSafeArea()
                ScrollView{
                    VStack(alignment: .leading, spacing: 0){
                        SearchBarView(searchText: $vm.searchText)
                        coinLogoList
                        
                        if selectedCoin != nil {
                            portfolioInputSection
                        }
                    }
                }
                .navigationTitle("Edit Portfolio")
                .toolbar(content: {
                    ToolbarItem(placement: .navigationBarLeading, content: {
                        XMarkButton()
                    })
                    
                    ToolbarItem(placement: .navigationBarTrailing, content: {
                        trailingNavBarButton
                    })
                })
                .onChange(of: vm.searchText) { value in
                    if value == ""{
                        removeSelectedCoin()
                    }
                }
            }
        }
    }
}

struct PortfolioView_Previews: PreviewProvider {
    static var previews: some View {
        PortfolioView()
            .environmentObject(dev.homeVM)
    }
}


extension PortfolioView{
    
    private var coinLogoList : some View {
        
        ScrollView(.horizontal, showsIndicators: false, content: {
            LazyHStack(spacing: 10 ){
                ForEach(vm.searchText.isEmpty ? vm.portfolioCoins : vm.allCoins ){
                    coin in
                    CoinLogoView(coin: coin)
                        .frame(width: 75)
                        .padding(4)
                        .onTapGesture {
                            withAnimation(.easeIn) {
                                updateSelectedCoin(coin: coin)
                            }
                            
                        }
                        .background(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(
                                selectedCoin?.id == coin.id ?
                                Color.theme.green : Color.clear, lineWidth: 1))
                }
                
            }
            .frame(height: 120)
            .padding(.leading)
        })
    }
    
    private func updateSelectedCoin(coin: CoinModel){
        selectedCoin = coin
        
     if let portfolioCoin = vm.portfolioCoins.first(where: {$0.id == coin.id }),
        let amount = portfolioCoin.currentHoldings {
         quantityText = "\(amount)"
     } else {
         quantityText = ""
     }
        
    }
    
    private func getCurrentValue() -> Double {
        
        if let quantity = Double(quantityText) {
            return quantity * (selectedCoin?.currentPrice ?? 0)
        }
        return 0
    }
    
    private var portfolioInputSection: some View {
        
        VStack(spacing: 20){
            HStack{
                Text("Current price of \(selectedCoin?.symbol.uppercased() ?? ""): ")
                Spacer()
                Text(selectedCoin?.currentPrice.asCurrencyWith6Decimals() ?? "")
            }
            Divider()
            HStack{
                Text("Portfolio amount:")
                Spacer()
                TextField("Ex: 3.7", text: $quantityText)
                    .multilineTextAlignment(.trailing)
                    .keyboardType(.decimalPad)
                
            }
            Divider()
            HStack{
                Text("Current value:")
                Spacer()
                Text(getCurrentValue().asCurrencyWith2Decimals())
                
            }
        }
        .animation(nil, value: UUID())
        .background(Color.theme.background)
        .font(.headline)
        .padding()
        
    }
    
    
    private var trailingNavBarButton: some View {
        
        HStack(spacing: 10){
            Image(systemName: "checkmark")
                .opacity(showCheckmark ? 1.0 : 0.0)
            
            Button {
                saveButtonPressed()
            } label: {
                Text("Save".uppercased())
                    .opacity(
                        (selectedCoin != nil && selectedCoin?.currentHoldings != Double(quantityText)) ? 1.0 : 0.0)
            }

            
        }
        .font(.headline)
        
    }
    
    private func saveButtonPressed() {
        guard
            let coin = selectedCoin,
            let amount = Double(quantityText)
            else {return}
        
        // save to portfolio
        vm.updatePortfolio(coin: coin, amount: amount)
        
        // show checkmark
            withAnimation(.easeIn){
                showCheckmark = true
                removeSelectedCoin()
        }
        
        // hide keyboard
        UIApplication.shared.endEditing()
        
        // hide checkmark
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0){
            withAnimation(.easeOut){
                showCheckmark = false
            }
        }
    }
    
    private func removeSelectedCoin(){
        selectedCoin = nil
        vm.searchText = ""
    }
}


