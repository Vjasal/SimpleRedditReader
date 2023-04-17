import SwiftUI

struct SubredditViewContent: View {

    @ObservedObject var viewModel = SubredditViewModel(subredditName: "LivestreamFail")

    var body: some View {
        ZStack {
            Color.gray.ignoresSafeArea()
            VStack(alignment: .leading, spacing: 0) {
                List(viewModel.posts) { post in
                    Text(post.title)
                }
                .listStyle(.plain)
            }
        }
    }
}

struct SubredditView: View {
    @State var visibleMenuWidth: Double = 0

    var body: some View {
        ZStack {
            VStack {
                Button {
                    withAnimation(.matherialEaseInOut(duration: 0.4)) {
                        visibleMenuWidth = SubredditListView.maxWidth
                    }
                } label: {
                    Text("Test")
                        .bold()
                        .foregroundColor(Color.white)
                        .frame(width: 200, height: 50, alignment: .center)
                        .background(Color(.systemBlue))
                }
            }
            .padding()

//            SubredditViewContent()
            SubredditListView(visibleMenuWidth: $visibleMenuWidth)
        }
    }
}

struct SubredditView_Previews: PreviewProvider {
    static var previews: some View {
        SubredditView()
    }
}
