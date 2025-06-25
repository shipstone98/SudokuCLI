//
//  SudokuSolverStrategy+CustomStringConvertible.swift
//  SudokuCli
//
//  Created by Christopher Shipstone on 25/06/2025.
//

extension SudokuSolverStrategy : CustomStringConvertible {
    public var description: String {
        switch self {
        case .fullHouse:
            return "Full House"
        case .nakedSingle:
            return "Naked Single"
        case .hiddenSingle:
            return "Hidden Single"
        case .pointingCandidate:
            return "Pointing Candidate"
        case .claimingCandidate:
            return "Claiming Candidate"
        case .nakedPair:
            return "Naked Pair"
        case .hiddenPair:
            return "Hidden Pair"
        case .xWing:
            return "X-Wing"
        case .uniqueRectangleType1:
            return "Unique Rectangle Type 1"
        }
    }
}
