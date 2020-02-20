// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let playlist = try? newJSONDecoder().decode(Playlist.self, from: jsonData)

import Foundation

// MARK: - Playlist
struct Playlist: Codable {
    let kind, etag: String
    let pageInfo: PageInfo
    let items: [Item]

    init(kind: String, etag: String, pageInfo: PageInfo, items: [Item]) {
        self.kind = kind
        self.etag = etag
        self.pageInfo = pageInfo
        self.items = items
    }
}

// MARK: - Item
struct Item: Codable {
    let kind: Kind
    let etag, id: String
    let snippet: Snippet
}

enum Kind: String, Codable {
    case youtubePlaylist = "youtube#playlist"
}

// MARK: - Snippet
struct Snippet: Codable {
    let publishedAt: String
    let channelID: ChannelID
    let title, snippetDescription: String
    let thumbnails: Thumbnails
    let channelTitle: ChannelTitle
    let localized: Localized

    enum CodingKeys: String, CodingKey {
        case publishedAt
        case channelID = "channelId"
        case title
        case snippetDescription = "description"
        case thumbnails, channelTitle, localized
    }
}

enum ChannelID: String, Codable {
    case ucLtPOhNcK2OSEJl43YQWw = "UCLtPOhNcK2_oSeJl43y-qWw"
}

enum ChannelTitle: String, Codable {
    case americanCenterMoscow = "American Center Moscow"
}

// MARK: - Localized
struct Localized: Codable {
    let title, localizedDescription: String

    enum CodingKeys: String, CodingKey {
        case title
        case localizedDescription = "description"
    }

}

// MARK: - Thumbnails
struct Thumbnails: Codable {
    let thumbnailsDefault, medium, high: Default
    let standard, maxres: Default?

    enum CodingKeys: String, CodingKey {
        case thumbnailsDefault = "default"
        case medium, high, standard, maxres
    }
}

// MARK: - Default
class Default: Codable {
    let url: String
    let width, height: Int


}

// MARK: - PageInfo
struct PageInfo: Codable {
    let totalResults, resultsPerPage: Int
}
