//
//  NewsAppApp.swift
//  NewsApp
//
//  Created by Nafisa Annesha on 12/9/22.
//

import SwiftUI
@main
struct NewsAppApp: App {
   
   
    var body: some Scene {
        WindowGroup {
            
            ContentView().environmentObject(Helper())
        }
    }
}
