import Foundation
import Combine
import Alamofire

class SubredditViewModel: ObservableObject {

    @Published var posts: [Post] = []

    private let baseUrl: String = "https://api.reddit.com/r/"
    private var subscriptions: Set<AnyCancellable> = []

    init(subredditName: String) {
        fetchPosts(subredditName: subredditName)
    }

    private func fetchPosts(subredditName: String) {
        AF.request(baseUrl + subredditName, method: .get)
            .publishDecodable(type: RedditResponse.self)
            .sink { [weak self] response in
                switch response.result {
                case .success(let response):
                    print("success c=\(response.data.children.count)")
                    self?.posts = response.data.children
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                }
            }
            .store(in: &subscriptions)
    }
}
