//
//  SearchBarView.swift
//  CryptoTracker
//
//  Created by Yuliia on 07.05.23.
//

import SwiftUI

struct SearchBarView: View {
    
    @Binding var searchText: String
    
    var body: some View {
        
        HStack{
            Image(systemName: "magnifyingglass")
                .foregroundColor(
                    searchText.isEmpty ?
                    Color.theme.secondaryText : Color.theme.accent)
            
            TextField("Search by name or symbol ...", text: $searchText)
                .foregroundColor(Color.theme.accent)
                .disableAutocorrection(true)
                .overlay(
                Image(systemName: "xmark.circle.fill")
                    .padding()
                    .offset(x: 10)
                    .foregroundColor(Color.theme.accent)
                    .opacity(searchText.isEmpty ? 0.0 : 1.0)
                    .onTapGesture {
                        UIApplication.shared.endEditing()
                        searchText = ""
                    }
                ,alignment: .trailing
                
                )
        }
        .font(.headline)
        .padding()
        // Neuromorphic Effect
        .modifier(customNeuromorphicBackground(cornerRadius: 25, neuromorphicShadow: true))
        .padding()
        
    }
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        
        Group{
            SearchBarView(searchText: .constant(""))
                //.previewLayout(.sizeThatFits)
                .preferredColorScheme(.light)
            
            SearchBarView(searchText: .constant(""))
              //  .previewLayout(.sizeThatFits)
                .preferredColorScheme(.dark)
        }
    }
}
