//
//  ContentView.swift
//  Webster
//
//  Created by Arthur Roolfs on 11/26/22.
//

import Foundation
import SwiftUI

enum TabType: Int, CaseIterable {
    case webview
    
    func title() -> String {
        switch self {
  
        case .webview:
            return "web".capitalized
     
        }
    }
    
    func image() -> String {
        switch self {
     
        case .webview:
            return "webView"
    
        }
    }
    
}
