//
//  CombinatorySudokuSolver.swift
//  SudokuCli
//
//  Created by Christopher Shipstone on 04/04/2025.
//

public struct CombinatorySudokuSolver: SudokuSolver {
    private var grid: SudokuGrid
    public private(set) var moves: [SudokuSolverMove]
    
    public var sudoku: Sudoku {
        self.grid
    }
    
    public init(_ sudoku: Sudoku) {
        self.grid = SudokuGrid(sudoku)
        self.moves = []
    }
    
    public mutating func solve<T>(using generator: inout T) -> Bool where T : RandomNumberGenerator {
        var strategySolver = StrategicSudokuSolver(self.grid)
        var isSolved = strategySolver.solve(using: &generator)
        self.grid = strategySolver.grid
        self.moves.append(contentsOf: strategySolver.moves)
        
        guard !isSolved else {
            return true
        }
        
        var recursiveSolver = RecursiveSudokuSolver(strategySolver.grid)
        isSolved = recursiveSolver.solve(using: &generator)
        self.moves.append(contentsOf: recursiveSolver.moves)
        self.grid = recursiveSolver.grid
        return isSolved
    }
}
