//
//  main.swift
//  SudokuCli
//
//  Created by Christopher Shipstone on 01/04/2025.
//

import Foundation

fileprivate func parseSudokuGrid(_ string: String) -> SudokuGrid {
    var grid = SudokuGrid()
    
    for row in 0..<9 {
        for column in 0..<9 {
            let index =
                string.index(string.startIndex, offsetBy: row * 9 + column)
            
            grid[row, column] = string[index].wholeNumberValue ?? 0
        }
    }
    
    return grid
}

fileprivate func solve() {
    /*
     var grid = SudokuGrid()
     var solver = RecursiveSudokuSolver(sudoku: grid)
     _ = solver.solve()
     let s = solver.sudoku.print()
     print(s)
     */

    // Easy sudoku: 501249700209730015073000028005800602040027800728103000307006000810470396000002100
    // Extreme sudoku: 500600000800000090030052004000700001300061800060400000050013002000007000002000400

    // Pointing candidate: 340006070080000930002030060000010000097364850000002000000000000000608090000923785
    // Claiming candidate (row): 318005406000603810006080503864952137123476958795318264030500780000007305000039641
    // Claiming candidate (column): 762008001980000006150000087478003169526009873319800425835001692297685314641932758
    // Naked pair (row): 700849030928135006400267089642783951397451628815692300204516093100008060500004010
    // Naked pair (column): 79463821502049100008027540081274650043685910095731268400096300030852096109180300
    // Naked pair (block): 687004523953002614142356978310007246760000305020000701096001032230000057070000069
    // X-Wing (row): 041729030769003402032640719403900170607004903195370024214567398376090541958431267
    // X-Wing (column): 980062753065003000327050006790030500050009000832045009673591428249087005518020007

    // NYT hard: 000000500080007002007034000000003000000000021010090635036040100400000057008020000
    // Devillish 123sudoku.co.uk: 096000700000001905050460080000503000040690003000080000010046500080105009000800040
    // Partially solved: 096058704000001965050469080000513400040690803000084000010946508080105009000800040

    let grid =
        parseSudokuGrid("096000700000001905050460080000503000040690003000080000010046500080105009000800040")

    var s = grid.print()
    print(s)
    var solver = CombinatorySudokuSolver(sudoku: grid)
    _ = solver.solve()
    s = solver.sudoku.print()
    print(s)
    var moveCount = 1

    for move in solver.moves {
        let strategyString: String
        
        if let strategy = move.strategy {
            strategyString = "\(strategy)"
        } else {
            strategyString = "Recursion"
        }
        
        print("Move \(moveCount): \(strategyString)")
        
        for location in move.locations {
            let removedCandidates = location.removedCandidates
            
            if removedCandidates.isEmpty {
                print("\(location.row),\(location.column),\(location.addedValue)")
            } else {
                print("\(location.row),\(location.column),\(location.addedValue),\(removedCandidates)")
            }
        }
        
        moveCount += 1
    }
}

solve()
