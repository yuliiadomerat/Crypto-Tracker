//
//  UIApplication.swift
//  CryptoTracker
//
//  Created by Yuliia on 07.05.23.
//

import Foundation
import SwiftUI

extension UIApplication {
    
    func endEditing(){
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        
    }
}

