//
//  CoinRowView.swift
//  CryptoTracker
//
//  Created by Yuliia on 27.04.23.
//

import SwiftUI

struct CoinRowView: View {
    
    let coin: CoinModel
    let showHoldingsColumn: Bool
    
    var body: some View {
        HStack(spacing: 0){
            leftColumn
            Spacer()
            if showHoldingsColumn {
                centerColumn
                .foregroundColor(Color.theme.accent)
            }
            rightColumn
        }
        .font(.subheadline)
        .contentShape(Rectangle())
        .padding()
        .modifier(customNeuromorphicBackground(cornerRadius: 10, neuromorphicShadow: false))
        .padding(.horizontal)
    }
}

struct CoinRowView_Previews: PreviewProvider {
    static var previews: some View {
        
        Group {
            CoinRowView(coin: dev.coin, showHoldingsColumn: true)
                .previewLayout(.sizeThatFits)
            
            CoinRowView(coin: dev.coin, showHoldingsColumn: true)
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.dark)
        }
    }
}


extension CoinRowView {
    
    private var leftColumn: some View{
        
        HStack(spacing: 0){
            CoinImageView(coin: coin)
                .frame(width: 30, height: 30)
            
            Text(coin.symbol.uppercased())
                .font(.headline)
                .padding(.leading, 6)
                .foregroundColor(Color.theme.accent)
        }
    }
    
    private var centerColumn: some View {
        
        VStack(alignment: .trailing){
            Text(coin.currentHoldingsValue.asCurrencyWith2Decimals())
                .bold()
            Text((coin.currentHoldings ?? 0).asNumberString())
        }
        
    }
    
    private var rightColumn: some View {
        
        VStack(alignment: .trailing){
            
            Text(coin.currentPrice.asCurrencyWith6Decimals())
                .bold()
                .foregroundColor(Color.theme.secondaryText)
            Text(coin.priceChangePercentage24H?.asPercentString() ?? "")
                .foregroundColor(
                    (coin.priceChangePercentage24H ?? 0 ) >= 0 ? Color.theme.green:
                        Color.theme.red
                
                
                )
        }
        .frame(width: UIScreen.main.bounds.width/3.5, alignment: .trailing)
    }
    
    
}
