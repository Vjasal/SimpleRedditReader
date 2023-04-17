import Foundation
import Combine
import Alamofire

class SubredditListViewModel: ObservableObject {
    
    private var allSubreddits: [Subreddit] = []
    @Published var subreddits: [Subreddit] = []
    @Published var searchText: String = ""
    
    private var subscriptions = Set<AnyCancellable>()

    init() {
        fetchSubreddits()
        setupSeatchFilter()
    }

    private func fetchSubreddits() {
        allSubreddits.append(Subreddit(name: "All"))
        allSubreddits.append(Subreddit(name: "LivestreamFail"))
        allSubreddits.append(Subreddit(name: "LeagueOfLegends"))
        
        allSubreddits.append(Subreddit(name: "Test0"))
        allSubreddits.append(Subreddit(name: "Test1"))
        allSubreddits.append(Subreddit(name: "Test2"))
        allSubreddits.append(Subreddit(name: "Test3"))
        allSubreddits.append(Subreddit(name: "Test4"))
        allSubreddits.append(Subreddit(name: "Test5"))
        allSubreddits.append(Subreddit(name: "Test6"))
        allSubreddits.append(Subreddit(name: "Test7"))
        allSubreddits.append(Subreddit(name: "Test8"))
        allSubreddits.append(Subreddit(name: "Test9"))
    }
    
    private func setupSeatchFilter() {
        $searchText
            .sink { [weak self] value in
                guard value.isEmpty == false else {
                    self?.subreddits = self?.allSubreddits ?? []
                    return
                }
                self?.subreddits = self?.allSubreddits.filter({ $0.name.lowercased().prefix(value.count) == value.lowercased() || $0.name.lowercased().contains(value.lowercased()) }) ?? []
            }
            .store(in: &subscriptions)
    }
}
