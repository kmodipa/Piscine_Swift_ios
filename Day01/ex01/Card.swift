import Foundation

class Card : NSObject {

	var color: Color;
	var value: Value;
	override var description: String {
		get {
			return "\(color), \(value)"
		}
	}

	/* Constructor */
	init(color: Color, value: Value) {
		self.color = color;
		self.value = value;
	}

	/* Function Overriding */
	override func isEqual(_ receiver: AnyObject?) -> Bool {
		if let otherCardObject = receiver as? Card {
			return (self.color == otherCardObject.color  && self.value == otherCardObject.value)
		} else {
			return false
		}
	}

	/* Operator Overloading */
	static func ==(lhs: Card, rhs: Card) -> Bool {
		return (lhs.color == rhs.color && lhs.value == rhs.value)
    }
}