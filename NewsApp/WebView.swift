//
//  WebView.swift
//  NewsApp
//
//  Created by Nafisa Annesha on 12/9/22.

import SwiftUI


struct WebView: View {
    
    @State private var showProgress: Bool = false
    @Binding var urlString: String
    @State var state = WebViewRep.State.standby
    @State private var showAlert = false
    @State var timeRemaining = 5
   let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @FocusState var focus: Bool

    var body: some View {
        
        VStack {

            ZStack {
                WebViewRep(urlString: $urlString, state: $state)
                    .opacity(state == .done ? 1 : 0)
                
                if state == .inProgress {
                   
                    ProgressView()
                        .onReceive(timer) { _ in
                                        if timeRemaining > 0 {
                                            timeRemaining -= 1
                                        }
                            if(timeRemaining == 0){
                                showAlert = true
                            }
                            
                            
                }
            }
            
            Spacer()
            }
        }
        .alert("Taking too long? Try opening in browser", isPresented: $showAlert) {
                   Button("OK", role: .cancel) {
                       showAlert = false
                   }
               }

        .padding()
    }
}

