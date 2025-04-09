//
//  CombinatorySudokuSolver.swift
//  SudokuCli
//
//  Created by Christopher Shipstone on 04/04/2025.
//

public struct CombinatorySudokuSolver: SudokuSolver {
    private var grid: SudokuGrid
    private var movesMutable: [SudokuSolverMove]
    
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
        var strategySolver = StrategicSudokuSolver(sudoku: self.grid)
        var isSolved = strategySolver.solve()
        self.grid = strategySolver.grid
        self.movesMutable.append(contentsOf: strategySolver.movesMutable)
        
        guard !isSolved else {
            return true
        }
        
        var recursiveSolver =
            RecursiveSudokuSolver(sudoku: strategySolver.grid)
        
        isSolved = recursiveSolver.solve()
        self.movesMutable.append(contentsOf: recursiveSolver.movesMutable)
        self.grid = recursiveSolver.grid
        return isSolved
    }
}
