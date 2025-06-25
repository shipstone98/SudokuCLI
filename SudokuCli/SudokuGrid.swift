//
//  SudokuGrid.swift
//  SudokuCli
//
//  Created by Christopher Shipstone on 01/04/2025.
//

public struct SudokuGrid : Codable, Hashable, Sendable, Sudoku {
    internal var cells: [Int]
    
    public subscript(row: Int, column: Int) -> Int {
        get {
            self.cells[row * 9 + column]
        } set {
            self.cells[row * 9 + column] = newValue
        }
    }
    
    public init() {
        self.cells = Array(repeating: 0, count: 81)
    }
    
    public init(_ sudoku: Sudoku) {
        var grid: [Int] = []
        
        for row in 0..<9 {
            for column in 0..<9 {
                grid.append(sudoku[row, column])
            }
        }
        
        self.cells = grid
    }
}
