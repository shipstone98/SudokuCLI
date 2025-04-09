//
//  SudokuSolverStrategy.swift
//  SudokuCli
//
//  Created by Christopher Shipstone on 01/04/2025.
//

public enum SudokuSolverStrategy : CaseIterable, CustomStringConvertible {
    case fullHouse
    case nakedSingle
    case hiddenSingle
    case pointingCandidate
    case claimingCandidate
    case nakedPair
    case hiddenPair
    case xWing
    
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
        }
    }
}
