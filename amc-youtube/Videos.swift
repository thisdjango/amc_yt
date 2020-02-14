// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let video = try? newJSONDecoder().decode(Video.self, from: jsonData)

import Foundation

// MARK: - Videos
struct Videos: Codable {
    let kind, etag: String
    let pageInfo: PageInfo
    let items: [ItemVideo]
}

// MARK: - Item
struct ItemVideo: Codable {
    let kind, etag, id: String
    let snippet: SnippetVideo
}

// MARK: - Snippet
struct SnippetVideo: Codable {
    let publishedAt, channelID, title, snippetDescription: String
    let thumbnails: Thumbnails
    let channelTitle, playlistID: String
    let position: Int
    let resourceID: ResourceID

    enum CodingKeys: String, CodingKey {
        case publishedAt
        case channelID = "channelId"
        case title
        case snippetDescription = "description"
        case thumbnails, channelTitle
        case playlistID = "playlistId"
        case position
        case resourceID = "resourceId"
    }
}

// MARK: - ResourceID
struct ResourceID: Codable {
    let kind, videoID: String

    enum CodingKeys: String, CodingKey {
        case kind
        case videoID = "videoId"
    }
}
