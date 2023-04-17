import Foundation

struct Post: Codable, Identifiable {
    let id = UUID()
    let title: String
    let score: Int
    let commentNumber: Int
    let media: Media?
    let author: String

    enum CodingKeys: String, CodingKey {
        case title = "title"
        case score = "ups"
        case commentNumber = "num_comments"
        case media = "secure_media"
        case author = "author_fullname"
    }
}

struct Media: Codable {
    let embed: Embed
    let type: String

    enum CodingKeys: String, CodingKey {
        case embed = "oembed"
        case type = "type"
    }
}

struct Embed: Codable {
    let thumbnailUrl: String
    let width: Int
    let height: Int

    enum CodingKeys: String, CodingKey {
        case thumbnailUrl = "thumbnail_url"
        case width = "thumbnail_width"
        case height = "thumbnail_height"
    }
}
