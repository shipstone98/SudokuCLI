//
//  SudokuSolverMoveLocation.swift
//  SudokuCli
//
//  Created by Christopher Shipstone on 01/04/2025.
//

public struct SudokuSolverMoveLocation : Comparable {
    public let addedValue: Int
    public let column: Int
    public let removedCandidates: [Int]
    public let row: Int
    
    internal init(
        _ row: Int,
        _ column: Int,
        _ addedValue: Int,
        _ removedCandidates: Int...
    ) {
        self.addedValue = addedValue
        self.column = column
        self.removedCandidates = Array(removedCandidates)
        self.row = row
    }
    
    internal init(
        _ row: Int,
        _ column: Int,
        _ addedValue: Int,
        _ removedCandidates: [Int]
    ) {
        self.addedValue = addedValue
        self.column = column
        self.removedCandidates = Array(removedCandidates)
        self.row = row
    }
    
    public static func <(
        lhs: SudokuSolverMoveLocation,
        rhs: SudokuSolverMoveLocation
    ) -> Bool {
        return lhs.row * 9 + lhs.column < rhs.row * 9 + rhs.column
    }
    
    public static func ==(
        lhs: SudokuSolverMoveLocation,
        rhs: SudokuSolverMoveLocation
    ) -> Bool {
        return lhs.row == rhs.row && lhs.column == rhs.column
    }
}
