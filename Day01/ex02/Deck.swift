import AppKit

class Deck: NSObject{
    static let allSpades:[Card] = Value.allValues.compactMap({Card(color: Color.Spades, value: $0)})
    static let allHearts:[Card] = Value.allValues.compactMap({Card(color: Color.Hearts, value: $0)})
    static let allClubs:[Card] = Value.allValues.compactMap({Card(color: Color.Clubs, value: $0)})
    static let allDiamonds:[Card] = Value.allValues.compactMap({Card(color: Color.Diamonds, value: $0)})

    static let allCards:[Card] = allSpades + allHearts + allClubs + allDiamonds
}