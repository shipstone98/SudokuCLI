//
//  RecursiveSudokuSolver.swift
//  SudokuCli
//
//  Created by Christopher Shipstone on 01/04/2025.
//

public struct RecursiveSudokuSolver : SudokuSolver {
    internal var grid: SudokuGrid
    internal private(set) var movesMutable: [SudokuSolverMove]
    
    public var moves: [SudokuSolverMove] {
        return self.movesMutable
    }
    
    public var sudoku: Sudoku {
        return self.grid
    }
    
    public init(sudoku: Sudoku) {
        self.grid = SudokuGrid(sudoku: sudoku)
        self.movesMutable = []
    }
    
    public mutating func solve() -> Bool {
        return self.solve(index: 0)
    }
    
    private mutating func solve(index: Int) -> Bool {
        if self.grid.cells[index] > 0 {
            return self.solveNext(index: index)
        }
        
        var candidates = self.grid.getCandidates(index: index)
        candidates.shuffle()
        
        for candidate in candidates {
            self.grid.cells[index] = candidate
            
            let location =
                SudokuSolverMoveLocation(index / 9, index % 9, candidate)
            
            let move = SudokuSolverMove(nil, location)
            self.movesMutable.append(move)
            
            if self.solveNext(index: index) {
                return true
            }
            
            self.movesMutable.removeLast()
        }
        
        self.grid.cells[index] = 0
        return false
    }
    
    private mutating func solveNext(index: Int) -> Bool {
        return index == 80 || self.solve(index: index + 1)
    }
}
