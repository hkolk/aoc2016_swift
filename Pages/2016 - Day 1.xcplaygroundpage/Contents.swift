//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

1234 * 0.01

public let defaultFormatter: NumberFormatter = {
    let formatter = NumberFormatter()
    //formatter.numberStyle = .currency
    formatter.multiplier = 0.01
    //formatter.locale = Locale(identifier: "nl_NL")
    formatter.minimumFractionDigits = 2
    formatter.maximumFractionDigits = 2
    return formatter
}()
print(defaultFormatter.string(from: 1234) ?? "")

//let input = "R5, L5, R5, R3"
let input = "R3, L5, R1, R2, L5, R2, R3, L2, L5, R5, L4, L3, R5, L1, R3, R4, R1, L3, R3, L2, L5, L2, R4, R5, R5, L4, L3, L3, R4, R4, R5, L5, L3, R2, R2, L3, L4, L5, R1, R3, L3, R2, L3, R5, L194, L2, L5, R2, R1, R1, L1, L5, L4, R4, R2, R2, L4, L1, R2, R53, R3, L5, R72, R2, L5, R3, L4, R187, L4, L5, L2, R1, R3, R5, L4, L4, R2, R5, L5, L4, L3, R5, L2, R1, R1, R4, L1, R2, L3, R5, L4, R2, L3, R1, L4, R4, L1, L2, R3, L1, L1, R4, R3, L4, R2, R5, L2, L3, L3, L1, R3, R5, R2, R3, R1, R2, L1, L4, L5, L2, R4, R5, L2, R4, R4, L3, R2, R1, L4, R3, L3, L4, L3, L1, R3, L2, R2, L4, L4, L5, R3, R5, R3, L2, R5, L2, L1, L5, L1, R2, R4, L5, R2, L4, L5, L4, L5, L2, L5, L4, R5, R3, R2, R2, L3, R3, L2, L5"
//let input = "R8, R4, R4, R8"
let moves = input.replacingOccurrences(of: " ", with: "").split(separator: ",")

enum Direction {
    case north
    case west
    case south
    case east
    
    func changeDirection(change: Character) -> Direction {
        switch self {
            case .north: return (change == "L") ? .west : .east
            case .west: return (change == "L") ? .south : .north
            case .south: return (change == "L") ? .east : .west
            case .east: return (change == "L") ? .north : .south
        }
    }
}

struct Coords: Equatable, Hashable {
    let x:Int
    let y:Int
    
    func move(direction:Direction, steps:Int) -> Coords {
        switch direction {
            case .north: return Coords(x:self.x, y:self.y+steps)
            case .south: return Coords(x:self.x, y:self.y-steps)
            case .east:  return Coords(x:self.x+steps, y:self.y)
            case .west:  return Coords(x:self.x-steps, y:self.y)
        }
    }
    
    func distanceFromZero() -> Int { return abs(x) + abs(y) }
    
    // Hashable
    var hashValue: Int {
        return x << 16 + y
    }
    
    // Equatable
    static func == (lhs: Coords, rhs: Coords) -> Bool {
        return lhs.x == rhs.x && lhs.y == rhs.y
    }
}

var pos = Coords(x: 0, y: 0)
var direction:Direction = .north

var history = Set<Coords>()

outer: for move in moves {
    let moveparts = Array(move)
    print("Starting from \(pos) facing \(direction), going \(move)")
    direction = direction.changeDirection(change: moveparts[0])
    print("- changed direction to \(direction)")
    let steps = Int(String(moveparts[1...]))!
    for _ in (1...steps).reversed() {
        pos = pos.move(direction: direction, steps: 1)
        print("- new pos: \(pos)")
        if(history.contains(pos)) {
            break outer
        } else {
            history.insert(pos)
        }
    }
}
print("New pos: \(pos), distance: \(pos.distanceFromZero())")



//: [Next](@next)
