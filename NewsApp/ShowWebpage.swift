//
//  ShowWebpage.swift
//  NewsApp
//
//  Created by Nafisa Annesha on 12/10/22.
//

//import Foundation
//import SwiftUI
//import WebKit
//
//struct ShowWebpage: UIViewRepresentable {
//    
//    enum State: String {
//        case standby, inProgress, error, done
//    }
//    
//      @Binding var urlString: String
//    @Binding var state: State
//    
//    class Coordinator: NSObject, WKNavigationDelegate {
//        var parent: ShowWebpage
//        
//        init(_ parent: ShowWebpage) {
//            self.parent = parent
//        }
//        
//        func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
//            parent.state = .inProgress
//        }
//        
//        func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
//            parent.state = .error
//        }
//        
//        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
//            parent.state = .done
//        }
//    }
//    
//    func makeCoordinator() -> Coordinator {
//        Coordinator(self)
//    }
//    
//    func makeUIView(context: Context) -> WKWebView {
//        let webView = WKWebView()
//        webView.navigationDelegate = context.coordinator
//        return webView
//    }
//    
//    func updateUIView(_ webView: WKWebView, context: Context) {
//        switch state {
//        case .standby:
//            if let url = URL(string: "") {
//                webView.load(URLRequest(url: url))
//            }
//        default: break
//        }
//    }
//}
