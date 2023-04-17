import SwiftUI

struct SubredditListViewContent: View {
    @ObservedObject var viewModel = SubredditListViewModel()

    var body: some View {
        VStack {
            TextField("Type a subreddit name", text: $viewModel.searchText)
                .padding()
                .background(Color.white)
                .clipped()
            List(viewModel.subreddits) { subreddit in
                Text(subreddit.name)
            }
            .listStyle(.plain)
        }
        .background(Color.gray
            .cornerRadius(20, corners: [.topRight, .bottomRight])
            .ignoresSafeArea())
        .ignoresSafeArea(.keyboard)
        .onTapGesture {
            hideKeyboard()
        }
    }
}

struct SubredditListView: View {
    static let maxWidth: Double = UIScreen.main.bounds.width * 0.8
    @Binding var visibleMenuWidth: Double
    @State var startingWidth: Double?

    var dragGesture: some Gesture {
        DragGesture()
            .onChanged { state in
                
                startingWidth = startingWidth ?? visibleMenuWidth
                let width = startingWidth! + state.translation.width
                visibleMenuWidth = width.clamped(0, Self.maxWidth)
            }
            .onEnded { state in
                hideKeyboard()
                
                let predictedEndWidth = (startingWidth ?? 0) + state.predictedEndTranslation.width
                startingWidth = nil

                withAnimation(.matherialEaseOut(duration: 0.2)) {
                    if predictedEndWidth < Self.maxWidth / 2 {
                        visibleMenuWidth = 0
                    } else {
                        visibleMenuWidth = Self.maxWidth
                    }
                }
            }
    }

    var backgroundOpacity: Double {
        visibleMenuWidth / Self.maxWidth
    }

    var menuOffset: Double {
        visibleMenuWidth - Self.maxWidth
    }

    var body: some View {
        ZStack {
            GeometryReader { _ in
                EmptyView()
            }
            .background(Color.black.opacity(0.6))
            .opacity(backgroundOpacity)
            .ignoresSafeArea()
            .onTapGesture {
                hideKeyboard()
                withAnimation(.matherialEaseInOut(duration: 0.4)) {
                    visibleMenuWidth = 0
                }
            }

            HStack {
                SubredditListViewContent()
                    .frame(width: Self.maxWidth)
                    .offset(x: menuOffset)
                    .gesture(dragGesture)
                Spacer()
            }
        }
    }
}

struct SubredditListView_Previews: PreviewProvider {

    @State static var visibleMenuWidth: Double = SubredditListView.maxWidth

    static var previews: some View {
        SubredditListView(visibleMenuWidth: $visibleMenuWidth)
    }
}
