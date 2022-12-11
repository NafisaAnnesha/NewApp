//
//  News.swift
//  NewsApp
//
//  Created by Nafisa Annesha on 12/9/22.
//

import Foundation





struct NewsResponse: Codable {
    let status: String
    let totalResults: Int
    let articles: [Article]
}

struct Article: Codable, Identifiable {
    let id = UUID()
    let source: Source
    let author: String?
    let title, articleDescription: String
    let url: String
    let urlToImage: String?
    let publishedAt: String? // <-- here
    let content: String
    
    enum CodingKeys: String, CodingKey {
        case source, author, title
        case articleDescription = "description"
        case url, urlToImage, publishedAt, content
    }
}
struct Source: Codable {
    let id: String?
    let name: String
}
//class NewsWebService: ObservableObject{
//    
//    @Published var news: NewsResponse?
//    
//    func getNews() async throws {
//            let (data, _) = try await URLSession.shared.data(from: Constants.url.pokeNews)
//            Task{@MainActor in
//                self.news = try JSONDecoder().decode(NewsResponse.self, from: data)
//            }
//    }
//}
