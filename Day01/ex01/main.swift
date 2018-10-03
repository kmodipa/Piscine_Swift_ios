import Foundation

/* Card instances/Objects */
var card1 = Card(color: Color.Clubs, value: Value.Ace)
var card2 = Card(color: Color.Clubs, value: Value.Ace)
var card3 = Card(color: Color.Spades, value: Value.two)
var card4 = Card(color: Color.Spades, value: Value.two)

/* Description printing */
print(card1.description)
print(card2.description)
print(card3.description)
print(card4.description)

/* Comparing Card1 and Card2 */
print("\nEqual: isEqual(\(card1.isEqual(to: card2))) ==(\(card1 == card2))")

/* Comparing Card1 and Card3 */
print("Equal: isEqual(\(card1.isEqual(to: card3))) ==(\(card1 == card3))")

/* Comparing Card1 and Card4 */
print("Equal: isEqual(\(card1.isEqual(to: card4))) ==(\(card1 == card4))")
