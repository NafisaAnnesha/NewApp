//
//  WebsiteView.swift
//  NewsApp
//
//  Created by Nafisa Annesha on 12/10/22.
//

//import SwiftUI
//
//
//struct WebsiteView: View {
//    
//    @State private var showProgress: Bool = false
//    @State private var urlString: String = "https://nasa.gov/"
//    @State var state = WebViewRep.State.standby
//    
//    @FocusState var focus: Bool
//
//    var body: some View {
//        
//        VStack {
//            
////            GoBarView(goString: $urlString, focus: _focus, title: "Url:") {
////                state = WebViewRep.State.standby
////            }
//            
//            ZStack {
//                
//                WebViewRep(urlString: $urlString, state: $state)
//                    .opacity(state == .done ? 1 : 0)
//                if state == .inProgress {
//                    ProgressView()
//                }
//            }
//            .onTapGesture { focus = false }
//            
//            Spacer()
//            
//        }
//        .padding()
//    }
//}
//
//struct WebView_Previews: PreviewProvider {
//    static var previews: some View {
//        WebsiteView()
//    }
//}
