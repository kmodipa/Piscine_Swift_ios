import AppKit
import Foundation

class Card : NSObject {
	var color: Color
	var value: Value
	override var description: String {
		get {
			return "Color: \(color.rawValue), Value: \(value.rawValue)"
		}
	}

	/* Constructor */
	init(color: Color, value: Value) {
		self.color = color;
		self.value = value;
	}

	/* Function Overriding */
	override func isEqual(_ receiver: Any?) -> Bool {
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