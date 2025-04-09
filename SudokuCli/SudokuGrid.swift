//
//  SudokuGrid.swift
//  SudokuCli
//
//  Created by Christopher Shipstone on 01/04/2025.
//

public struct SudokuGrid : Sudoku {
    internal var cells: [Int]
    
    public subscript(row: Int, column: Int) -> Int {
        get {
            return self.cells[row * 9 + column]
        }
        
        set {
            self.cells[row * 9 + column] = newValue
        }
    }
    
    public init() {
        self.cells = Array(repeating: 0, count: 81)
    }
    
    public init(sudoku: Sudoku) {
        var grid: [Int] = []
        
        for row in 0..<9 {
            for column in 0..<9 {
                grid.append(sudoku[row, column])
            }
        }
        
        self.cells = grid
    }
    
    private func blockContains(row: Int, column: Int, n: Int) -> Bool {
        let blockRow = row - row % 3
        let blockColumn = column - column % 3
        
        for rowOffset in 0..<3 {
            for columnOffset in 0..<3 {
                if self.cells[(blockRow + rowOffset) * 9 + blockColumn + columnOffset] == n {
                    return true
                }
            }
        }
        
        return false
    }
    
    private func columnContains(column: Int, n: Int) -> Bool {
        for row in 0..<9 {
            if self.cells[row * 9 + column] == n {
                return true
            }
        }
        
        return false
    }
    
    internal func getCandidates(index: Int) -> [Int] {
        if self.cells[index] > 0 {
            return []
        }
        
        let row = index / 9
        let column = index % 9
        var candidates: [Int] = []
        
        for n in 1...9 {
            if !(
                self.rowContains(row: row, n: n)
                || self.columnContains(column: column, n: n)
                || self.blockContains(row: row, column: column, n: n)
            ) {
                candidates.append(n)
            }
        }
        
        return candidates
    }
    
    private func rowContains(row: Int, n: Int) -> Bool {
        for column in 0..<9 {
            if self.cells[row * 9 + column] == n {
                return true
            }
        }
        
        return false
    }
}
