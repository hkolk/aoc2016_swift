//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

func printMatrix(_ matrix:Array<Array<Int>>) {
    for row in matrix {
        print(row.map{ ($0 > 0) ? "#" : "." }.joined())
    }
}

enum Instruction {
    case rect(x:Int, y:Int)
    case rotateColumn(x:Int, by:Int)
    case rotateRow(y:Int, by:Int)
    
    func execute(_ matrix:Array<Array<Int>>) -> Array<Array<Int>> {
        var newMatrix = matrix
        switch self {
        case .rect(let x, let y):
            for i in 0...y-1 {
                for j in 0...x-1 {
                    newMatrix[i][j] = 1
                }
            }
            return newMatrix
        case .rotateColumn(let x, let by):
            let columnSize = newMatrix.count
            for _ in 1...by {
                let lastpiece = newMatrix[columnSize - 1][x]
                for y in (1...columnSize - 1).reversed() {
                    newMatrix[y][x] = newMatrix[y-1][x]
                }
                newMatrix[0][x] = lastpiece
            }
            return newMatrix
        case .rotateRow(let y, let by):
            let rowSize = newMatrix[y].count
            for _ in 1...by {
                let lastpiece = newMatrix[y][rowSize - 1]
                for x in (1...rowSize - 1).reversed() {
                    newMatrix[y][x] = newMatrix[y][x-1]
                }
                newMatrix[y][0] = lastpiece
            }
            return newMatrix
        }
    }
    
    static func parseInstruction(_ instruction:String) -> Instruction {
        let parts = instruction.split(separator: " ").map{ String($0) }
        switch parts[0] {
            case "rect":
                let coords = parts[1].split(separator: "x").map { Int(String($0))! }
                return .rect(x: coords[0], y: coords[1])
            case "rotate":
                let locId = parts[2].split(separator: "=")
                if(parts[1] == "column") {
                    return .rotateColumn(x: Int(String(locId[1]))!, by: Int(parts[4])!)
                } else {
                    return .rotateRow(y: Int(String(locId[1]))!, by: Int(parts[4])!)
                }
            default: fatalError()
        }
    }
}

let matrixRows = 6
let matrixColumns = 50

let input = """
rect 3x2
rotate column x=1 by 1
rotate row y=0 by 4
rotate column x=1 by 1
"""

let input2 = """
rect 1x1
rotate row y=0 by 20
rect 1x1
rotate row y=0 by 2
rect 1x1
rotate row y=0 by 3
rect 2x1
rotate row y=0 by 2
rect 1x1
rotate row y=0 by 3
rect 2x1
rotate row y=0 by 2
rect 1x1
rotate row y=0 by 4
rect 2x1
rotate row y=0 by 2
rect 1x1
rotate row y=0 by 2
rect 1x1
rotate row y=0 by 2
rect 1x1
rotate row y=0 by 3
rect 2x1
rotate row y=0 by 2
rect 1x1
rotate row y=0 by 5
rect 1x1
rotate row y=0 by 2
rect 1x1
rotate row y=0 by 6
rect 5x1
rotate row y=0 by 2
rect 1x3
rotate row y=2 by 8
rotate row y=0 by 8
rotate column x=0 by 1
rect 7x1
rotate row y=2 by 24
rotate row y=0 by 20
rotate column x=5 by 1
rotate column x=4 by 2
rotate column x=2 by 2
rotate column x=0 by 1
rect 7x1
rotate column x=34 by 2
rotate column x=22 by 1
rotate column x=15 by 1
rotate row y=2 by 18
rotate row y=0 by 12
rotate column x=8 by 2
rotate column x=7 by 1
rotate column x=5 by 2
rotate column x=2 by 1
rotate column x=0 by 1
rect 9x1
rotate row y=3 by 28
rotate row y=1 by 28
rotate row y=0 by 20
rotate column x=18 by 1
rotate column x=15 by 1
rotate column x=14 by 1
rotate column x=13 by 1
rotate column x=12 by 2
rotate column x=10 by 3
rotate column x=8 by 1
rotate column x=7 by 2
rotate column x=6 by 1
rotate column x=5 by 1
rotate column x=3 by 1
rotate column x=2 by 2
rotate column x=0 by 1
rect 19x1
rotate column x=34 by 2
rotate column x=24 by 1
rotate column x=23 by 1
rotate column x=14 by 1
rotate column x=9 by 2
rotate column x=4 by 2
rotate row y=3 by 5
rotate row y=2 by 3
rotate row y=1 by 7
rotate row y=0 by 5
rotate column x=0 by 2
rect 3x2
rotate column x=16 by 2
rotate row y=3 by 27
rotate row y=2 by 5
rotate row y=0 by 20
rotate column x=8 by 2
rotate column x=7 by 1
rotate column x=5 by 1
rotate column x=3 by 3
rotate column x=2 by 1
rotate column x=1 by 2
rotate column x=0 by 1
rect 9x1
rotate row y=4 by 42
rotate row y=3 by 40
rotate row y=1 by 30
rotate row y=0 by 40
rotate column x=37 by 2
rotate column x=36 by 3
rotate column x=35 by 1
rotate column x=33 by 1
rotate column x=32 by 1
rotate column x=31 by 3
rotate column x=30 by 1
rotate column x=28 by 1
rotate column x=27 by 1
rotate column x=25 by 1
rotate column x=23 by 3
rotate column x=22 by 1
rotate column x=21 by 1
rotate column x=20 by 1
rotate column x=18 by 1
rotate column x=17 by 1
rotate column x=16 by 3
rotate column x=15 by 1
rotate column x=13 by 1
rotate column x=12 by 1
rotate column x=11 by 2
rotate column x=10 by 1
rotate column x=8 by 1
rotate column x=7 by 2
rotate column x=5 by 1
rotate column x=3 by 3
rotate column x=2 by 1
rotate column x=1 by 1
rotate column x=0 by 1
rect 39x1
rotate column x=44 by 2
rotate column x=42 by 2
rotate column x=35 by 5
rotate column x=34 by 2
rotate column x=32 by 2
rotate column x=29 by 2
rotate column x=25 by 5
rotate column x=24 by 2
rotate column x=19 by 2
rotate column x=15 by 4
rotate column x=14 by 2
rotate column x=12 by 3
rotate column x=9 by 2
rotate column x=5 by 5
rotate column x=4 by 2
rotate row y=5 by 5
rotate row y=4 by 38
rotate row y=3 by 10
rotate row y=2 by 46
rotate row y=1 by 10
rotate column x=48 by 4
rotate column x=47 by 3
rotate column x=46 by 3
rotate column x=45 by 1
rotate column x=43 by 1
rotate column x=37 by 5
rotate column x=36 by 5
rotate column x=35 by 4
rotate column x=33 by 1
rotate column x=32 by 5
rotate column x=31 by 5
rotate column x=28 by 5
rotate column x=27 by 5
rotate column x=26 by 3
rotate column x=25 by 4
rotate column x=23 by 1
rotate column x=17 by 5
rotate column x=16 by 5
rotate column x=13 by 1
rotate column x=12 by 5
rotate column x=11 by 5
rotate column x=3 by 1
rotate column x=0 by 1
"""

let instructions = input2.split(separator: "\n").map{ Instruction.parseInstruction(String($0)) }




var matrix = Array(repeating: Array(repeating: 0, count:matrixColumns), count: matrixRows)
instructions.forEach {
    //print($0)
    matrix = $0.execute(matrix)
    //printMatrix(matrix)
}
var lit = 0
for row in matrix {
    for element in row {
        if(element > 0) {
            lit += 1
        }
    }
}
print("Lit: \(lit)")
printMatrix(matrix)



//: [Next](@next)
