//
//  SudokuSolver.swift
//  SudokuCli
//
//  Created by Christopher Shipstone on 01/04/2025.
//

public protocol SudokuSolver {
    var moves: [SudokuSolverMove] { get }
    var sudoku: Sudoku { get }
    
    mutating func solve() -> Bool
}
