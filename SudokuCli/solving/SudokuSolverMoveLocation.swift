//
//  SudokuSolverMoveLocation.swift
//  SudokuCli
//
//  Created by Christopher Shipstone on 01/04/2025.
//

public struct SudokuSolverMoveLocation : Comparable, Codable, Hashable, Sendable {
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
    
    @inlinable
    public static func <(
        lhs: SudokuSolverMoveLocation,
        rhs: SudokuSolverMoveLocation
    ) -> Bool {
        lhs.row * 9 + lhs.column < rhs.row * 9 + rhs.column
    }
    
    @inlinable
    public static func ==(
        lhs: SudokuSolverMoveLocation,
        rhs: SudokuSolverMoveLocation
    ) -> Bool {
        lhs.row == rhs.row && lhs.column == rhs.column
    }
}
