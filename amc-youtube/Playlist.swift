// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let playlist = try? newJSONDecoder().decode(Playlist.self, from: jsonData)

import Foundation

// MARK: - Playlist
class Playlist: Codable {
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
class Item: Codable {
    let kind: Kind
    let etag, id: String
    let snippet: Snippet

    init(kind: Kind, etag: String, id: String, snippet: Snippet) {
        self.kind = kind
        self.etag = etag
        self.id = id
        self.snippet = snippet
    }
}

enum Kind: String, Codable {
    case youtubePlaylist = "youtube#playlist"
}

// MARK: - Snippet
class Snippet: Codable {
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

    init(publishedAt: String, channelID: ChannelID, title: String, snippetDescription: String, thumbnails: Thumbnails, channelTitle: ChannelTitle, localized: Localized) {
        self.publishedAt = publishedAt
        self.channelID = channelID
        self.title = title
        self.snippetDescription = snippetDescription
        self.thumbnails = thumbnails
        self.channelTitle = channelTitle
        self.localized = localized
    }
}

enum ChannelID: String, Codable {
    case ucLtPOhNcK2OSEJl43YQWw = "UCLtPOhNcK2_oSeJl43y-qWw"
}

enum ChannelTitle: String, Codable {
    case americanCenterMoscow = "American Center Moscow"
}

// MARK: - Localized
class Localized: Codable {
    let title, localizedDescription: String

    enum CodingKeys: String, CodingKey {
        case title
        case localizedDescription = "description"
    }

    init(title: String, localizedDescription: String) {
        self.title = title
        self.localizedDescription = localizedDescription
    }
}

// MARK: - Thumbnails
class Thumbnails: Codable {
    let thumbnailsDefault, medium, high: Default
    let standard, maxres: Default?

    enum CodingKeys: String, CodingKey {
        case thumbnailsDefault = "default"
        case medium, high, standard, maxres
    }

    init(thumbnailsDefault: Default, medium: Default, high: Default, standard: Default?, maxres: Default?) {
        self.thumbnailsDefault = thumbnailsDefault
        self.medium = medium
        self.high = high
        self.standard = standard
        self.maxres = maxres
    }
}

// MARK: - Default
class Default: Codable {
    let url: String
    let width, height: Int

    init(url: String, width: Int, height: Int) {
        self.url = url
        self.width = width
        self.height = height
    }
}

// MARK: - PageInfo
class PageInfo: Codable {
    let totalResults, resultsPerPage: Int

    init(totalResults: Int, resultsPerPage: Int) {
        self.totalResults = totalResults
        self.resultsPerPage = resultsPerPage
    }
}
