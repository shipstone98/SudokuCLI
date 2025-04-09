//
//  SudokuSolverMove.swift
//  SudokuCli
//
//  Created by Christopher Shipstone on 01/04/2025.
//

public struct SudokuSolverMove {
    public let locations: [SudokuSolverMoveLocation]
    public let strategy: SudokuSolverStrategy?
    
    internal init(
        _ strategy: SudokuSolverStrategy?,
        _ locations: SudokuSolverMoveLocation...
    ) {
        self.locations = locations.sorted()
        self.strategy = strategy
    }
    
    internal init(
        _ strategy: SudokuSolverStrategy?,
        _ locations: [SudokuSolverMoveLocation]
    ) {
        self.locations = locations.sorted()
        self.strategy = strategy
    }
}
