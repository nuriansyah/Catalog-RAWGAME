//
//  DataModel.swift
//  Catalog-RAWGAME.io
//
//  Created by Nuriansyah Malik on 08/10/22.
//

import Foundation

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation


struct Game: Codable, Identifiable{
    var id: Int {idGame}
    var idGame: Int
    let slug, name: String
    let released: Date
    let tba: Bool
    let backgroundImage: String
    let rating, ratingTop: Int
    let ratingsCount: Int
    let reviewsTextCount: String
    let added: Int
    let metacritic, playtime, suggestionsCount: Int
    let updated: Date
    
    
    
    init(idGame: Int, slug: String, name: String, released: Date, tba: Bool, backgroundImage: String, rating: Int, ratingTop: Int, ratingsCount: Int, reviewsTextCount: String, added: Int, metacritic: Int, playtime: Int, suggestionsCount: Int, updated: Date) {
        self.idGame = idGame
        self.slug = slug
        self.name = name
        self.released = released
        self.tba = tba
        self.backgroundImage = backgroundImage
        self.rating = rating
        self.ratingTop = ratingTop
        self.ratingsCount = ratingsCount
        self.reviewsTextCount = reviewsTextCount
        self.added = added
        self.metacritic = metacritic
        self.playtime = playtime
        self.suggestionsCount = suggestionsCount
        self.updated = updated
    }
}

// MARK: - Welcome
struct GameResponses: Codable {
    let count: Int
    let next, previous: String
    let results: [GameResponse]
    
    enum CodingKeys: String, CodingKey {
        case count
        case next
        case previous
        case results = "results"
    }
}

// MARK: - Result
struct GameResponse: Codable {
    let id: Int
    let slug, name: String
    let released: Date
    let tba: Bool
    let backgroundImage: String
    let rating, ratingTop: Int
    let ratingsCount: Int
    let reviewsTextCount: String
    let added: Int
    let metacritic, playtime, suggestionsCount: Int
    let updated: Date
    
    

    enum CodingKeys: String, CodingKey {
        case id, slug, name, tba
        case released
        case backgroundImage = "background_image"
        case rating
        case ratingTop = "rating_top"
        case ratingsCount = "ratings_count"
        case reviewsTextCount = "reviews_text_count"
        case added
        case metacritic, playtime
        case suggestionsCount = "suggestions_count"
        case updated
        
        
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        slug = try container.decode(String.self, forKey: .slug)
        name = try container.decode(String.self, forKey: .name)
        tba = try container.decode(Bool.self, forKey: .tba)
        let dateString = try container.decode(String.self, forKey: .released)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        released = dateFormatter.date(from: dateString)!
        backgroundImage = try container.decode(String.self, forKey: .backgroundImage)
        rating = try container.decode(Int.self, forKey: .rating)
        ratingTop = try container.decode(Int.self, forKey: .ratingTop)
        ratingsCount = try container.decode(Int.self, forKey: .ratingsCount)
        reviewsTextCount = try container.decode(String.self, forKey: .reviewsTextCount)
        added = try container.decode(Int.self, forKey: .added)
        metacritic = try container.decode(Int.self, forKey: .metacritic)
        playtime = try container.decode(Int.self, forKey: .playtime)
        suggestionsCount = try container.decode(Int.self, forKey: .suggestionsCount)
        updated = try container.decode(Date.self, forKey: .updated)

    }
}


class NetworkService: ObservableObject {
@Published var network: [Game] = []
    
  let key = "dd92aebe734a41a69a13c69a7a0d2cf8"
  let page_size = "5"
 
  func getMovies() async throws -> [Game] {
    var components = URLComponents(string: "https://api.rawg.io/api/games")!
    components.queryItems = [
      URLQueryItem(name: "key", value: key),
      URLQueryItem(name: "page_size", value: page_size)
    ]
    let request = URLRequest(url: components.url!)
 
    let (data, response) = try await URLSession.shared.data(for: request)
 
    guard (response as? HTTPURLResponse)?.statusCode == 200 else {
      fatalError("Error: Can't fetching data.")
    }
 
    let decoder = JSONDecoder()
    let result = try decoder.decode(GameResponses.self, from: data)
 
      return movieMapper(input: result.results)
  }
}
 
extension NetworkService {
  fileprivate func movieMapper(
    input movieResponses: [GameResponse]
  ) -> [Game] {
    return movieResponses.map { result in
        return Game(idGame: result.id, slug: result.slug, name: result.name, released: result.released, tba: result.tba, backgroundImage: result.backgroundImage, rating: result.rating, ratingTop: result.ratingTop, ratingsCount: result.ratingsCount, reviewsTextCount: result.reviewsTextCount, added: result.added, metacritic: result.metacritic, playtime: result.playtime, suggestionsCount: result.suggestionsCount, updated: result.updated )
    }
  }
}
