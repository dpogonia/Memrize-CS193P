import Foundation

struct MemoryGame<CardContent> {
    private(set) var cards: Array<Card>
    
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = Array<Card>()
        
        for _ in 0..<numberOfPairsOfCards {
            let content: CardContent = CardContent()
            card.append(Card(content: pairIndex))
            card.append(Card(content: pairIndex))
        }
        
    }
    
    func choose(_ card: Card) {
        
    }
    
    struct Card {
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var content: CardContent
    }
}

