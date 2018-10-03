/* All Cards Before*/
print("[All Cards Before]")
print(Deck.allCards)

/* Copping the array into a variable */
var cards:[Card] = Deck.allCards

/* Shuffling */
cards.shuffle()

print("\n[All Cards After]")
print(cards)
