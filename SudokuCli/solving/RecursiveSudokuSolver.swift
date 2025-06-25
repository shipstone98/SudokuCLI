//
//  RecursiveSudokuSolver.swift
//  SudokuCli
//
//  Created by Christopher Shipstone on 01/04/2025.
//

public struct RecursiveSudokuSolver : SudokuSolver {
    internal var grid: SudokuGrid
    public private(set) var moves: [SudokuSolverMove]
    
    public var sudoku: Sudoku {
        self.grid
    }
    
    public init(_ sudoku: Sudoku) {
        self.grid = SudokuGrid(sudoku)
        self.moves = []
    }
    
    @discardableResult
    public mutating func solve<T>(using generator: inout T) -> Bool where T : RandomNumberGenerator {
        self.solve(at: 0, using: &generator)
    }
    
    private mutating func solve<T>(
        at index: Int,
        using generator: inout T
    ) -> Bool where T : RandomNumberGenerator {
        guard self.grid.cells[index] == 0 else {
            return self.solveNext(at: index, using: &generator)
        }
        
        let row = index / 9
        let column = index % 9
        
        let candidates = self.grid
            .getCandidates(row, column)
            .shuffled(using: &generator)
        
        for candidate in candidates {
            self.grid.cells[index] = candidate
            let location = SudokuSolverMoveLocation(row, column, candidate)
            let move = SudokuSolverMove(nil, location)
            self.moves.append(move)
            
            guard !self.solveNext(at: index, using: &generator) else {
                return true
            }
            
            self.moves.removeLast()
        }
        
        self.grid.cells[index] = 0
        return false
    }
    
    private mutating func solveNext<T>(
        at index: Int,
        using generator: inout T
    ) -> Bool where T : RandomNumberGenerator {
        index == 80 || self.solve(at: index + 1, using: &generator)
    }
}
