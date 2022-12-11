//
//  Helper.swift
//  NewsApp
//
//  Created by Nafisa Annesha on 12/9/22.
//

import Foundation


class Helper: ObservableObject {
   // @Published var datas = [dataType]()
    let fmpUrl = "https://newsapi.org/v2/"
    @Published var news: NewsResponse?
    private func fmpUrl(symbol: String, parameters: [String:String]) -> URL? {
        
        var queryItems = [URLQueryItem]()

        for (key, value) in parameters {
            let item = URLQueryItem(name: key, value: value)
            queryItems.append(item)
        }
        
        guard var components = URLComponents(string: fmpUrl + symbol) else { return nil }
        components.queryItems = queryItems
        return components.url
    }
    
    func fetch(symbol: String, source: String) async throws {
        
        let params = ["apikey": Constant.apikey, "sources" : source]
        
        if let url = fmpUrl(symbol: symbol, parameters: params) {
            let request = URLRequest(url: url)
           
            let (data, response) = try await URLSession.shared.data(for: request)
           
            guard (response as? HTTPURLResponse)?.statusCode == 200 else { throw URLError.BadURL  }
          
       //     let decoder = JSONDecoder()
            Task{@MainActor in
                news =  try JSONDecoder().decode(NewsResponse.self, from: data)}
            
            //return articles
        }
     
        
    }

}
