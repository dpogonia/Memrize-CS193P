import SwiftUI

struct ContentView: View {
    var viewModel: EmojiMemoryGame
    
    // MARK: VARIABLES
    @State var emojis: Array<String> = ["🐱", "🐭", "🐰", "🦆","🦇", "🐯", "🦁", "🦉", "🦎", "🪿"]
    @State var emojis2: Array<String> = ["🐶", "🐻", "🐼", "🐨", "🐮", "🐷", "🐸", "🐵", "🐢", "🐍"]
    @State var emojisPack: Array<String> = []
    @State var cardCount = 8
    
    // MARK: FUNCTIONS
    func cardCountAdjuster(by offset: Int, symbol: String) -> some View {
        Button(action: {
            cardCount += offset
        }, label: {
            Image(systemName: symbol)
        })
        .disabled(cardCount + offset < 1 || cardCount + offset > emojisPack.count)
    }
    
    // MARK: MAIN VIEW
    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    cardsView
                }
                Spacer()
                HStack {
                    themeView(emojisPack: $emojisPack, theme: "cat", emojis: emojis, emojis2: emojis2)
                    Spacer()
                    cardCountAdjustersView
                    Spacer()
                    themeView(emojisPack: $emojisPack, theme: "dog", emojis: emojis, emojis2: emojis2)
                }
            }
            .foregroundStyle(.orange)
            .padding()
            .navigationTitle("Memorize!").font(.largeTitle)
            .navigationBarTitleDisplayMode(.automatic)
        }
        .onAppear {
            emojisPack = emojis // Initialize with the first emoji pack
        }
    }
    
    var cardsView: some View {
        return LazyVGrid(columns: [GridItem(.adaptive(minimum: 100, maximum: 150))]) {
            ForEach(0..<cardCount, id: \.self) { index in
                cardView(content: emojisPack[index])
                    .aspectRatio(2/3, contentMode: .fit)
            }
        }
    }
    
    var cardCountAdjustersView: some View {
        HStack {
            cardRemoverView
            cardAdderView
        }
        .imageScale(.large)
        .font(.title2)
    }
    
    var cardRemoverView: some View {
        return cardCountAdjuster(by: -1, symbol: "minus.square")
    }
    
    var cardAdderView: some View {
        return cardCountAdjuster(by: +1, symbol: "plus.app")
    }
}

struct cardView: View {
    @State var isFaceUp = true
    var content: String
    var body: some View {
        ZStack(alignment: .center, content: {
            let base = RoundedRectangle(cornerRadius: 12)
            Group {
                base.fill(.white)
                base.strokeBorder(style: StrokeStyle(lineWidth: 2, dash: [10, 2]))
                Text(content).font(.largeTitle)
            }
            .opacity(isFaceUp ? 1 : 0)
            base.fill().opacity(isFaceUp ? 0 : 1)
        })
        .onTapGesture(count: 2, perform: {
            isFaceUp.toggle()
        })
    }
}

struct themeView: View {
    @Binding var emojisPack: [String]
    var theme: String // Accept a string identifier for the theme
    var emojis: [String]
    var emojis2: [String]
    
    func themeViewAdjuster(symbol: String) -> some View {
        Button(action: {
            if theme == "cat" {
                emojisPack = emojis // Set emojis for the cat theme
            } else {
                emojisPack = emojis2 // Set emojis for the dog theme
            }
            emojisPack.shuffle()
        }, label: { Image(systemName: symbol) })
    }
    
    var body: some View {
        let icon = theme == "cat" ? "cat.fill" : "dog.fill" // Determine icon based on theme
        themeViewAdjuster(symbol: icon)
    }
}

#Preview {
    ContentView()
}
