//
//  SudokuSolverStrategy.swift
//  SudokuCli
//
//  Created by Christopher Shipstone on 01/04/2025.
//

public enum SudokuSolverStrategy : CaseIterable, Codable, Comparable, Hashable, Sendable {
    case fullHouse
    case nakedSingle
    case hiddenSingle
    case pointingCandidate
    case claimingCandidate
    case nakedPair
    case hiddenPair
    case xWing
    case uniqueRectangleType1
}
