import Foundation

struct RedditResponse: Codable {
    let kind: String
    let data: ResponseData
}

struct ResponseData: Codable {
    let after: String
    let before: String
    let children: [Post]
}
