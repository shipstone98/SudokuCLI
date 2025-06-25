//
//  SudokuSolver.swift
//  SudokuCli
//
//  Created by Christopher Shipstone on 01/04/2025.
//

public protocol SudokuSolver {
    var moves: [SudokuSolverMove] { get }
    var sudoku: Sudoku { get }
    
    @discardableResult
    mutating func solve<T>(using generator: inout T) -> Bool where T : RandomNumberGenerator
}

public extension SudokuSolver {
    @discardableResult
    mutating func solve() -> Bool {
        var generator = SystemRandomNumberGenerator()
        return self.solve(using: &generator)
    }
}
