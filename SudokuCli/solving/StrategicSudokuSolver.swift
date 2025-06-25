//
//  StrategicSudokuSolver.swift
//  SudokuCli
//
//  Created by Christopher Shipstone on 01/04/2025.
//

public struct StrategicSudokuSolver : SudokuSolver {
    internal private(set) var candidates: [[Int]]
    internal private(set) var grid: SudokuGrid
    public private(set) var moves: [SudokuSolverMove]
    private let strategies: [SudokuSolverStrategy]
    
    public var sudoku: Sudoku {
        self.grid
    }
    
    public init(_ sudoku: Sudoku) {
        var candidates: [[Int]] = []
        let grid = SudokuGrid(sudoku)
        
        for row in 0..<9 {
            for column in 0..<9 {
                let cellCandidates = grid.getCandidates(row, column)
                candidates.append(cellCandidates)
            }
        }
        
        self.candidates = candidates
        self.grid = grid
        self.moves = []
        self.strategies = SudokuSolverStrategy.allCases
    }
    
    private mutating func removeCandidates(row: Int, column: Int, n: Int) {
        for c in 0..<9 {
            self.candidates[row * 9 + c].removeAll { $0 == n }
        }
        
        for r in 0..<9 {
            self.candidates[r * 9 + column].removeAll { $0 == n }
        }
        
        let blockRow = row - row % 3
        let blockColumn = column - column % 3
        
        for rowOffset in 0..<3 {
            for columnOffset in 0..<3 {
                let index = ((blockRow + rowOffset) * 9)
                    + (blockColumn + columnOffset)
                
                self.candidates[index].removeAll { $0 == n }
            }
        }
    }
    
    @discardableResult
    public mutating func solve<T>(using generator: inout T) -> Bool where T : RandomNumberGenerator {
        self.solve(using: self.strategies)
    }
    
    @discardableResult
    public mutating func solve(using strategies: [SudokuSolverStrategy]) -> Bool {
        while true {
            var isSolved = false
            
            for strategy in strategies {
                guard !self.solveOnce(using: strategy) else {
                    isSolved = true
                    break
                }
            }
            
            guard isSolved else {
                break
            }
        }
        
        for index in 0..<81 {
            guard self.grid.cells[index] != 0 else {
                return false
            }
        }
        
        return true
    }
    
    @discardableResult
    public mutating func solveOnce(using strategy: SudokuSolverStrategy) -> Bool {
        let solver: StrategySolver
        
        switch strategy {
        case .fullHouse:
            solver = FullHouseStrategySolver(using: self)
        case .nakedSingle:
            solver = NakedSingleStrategySolver(using: self)
        case .hiddenSingle:
            solver = HiddenSingleStrategySolver(using: self)
        case .pointingCandidate:
            solver = PointingCandidateStrategySolver(using: self)
        case .claimingCandidate:
            solver = ClaimingCandidateStrategySolver(using: self)
        case .nakedPair:
            solver = NakedPairStrategySolver(using: self)
        case .hiddenPair:
            solver = HiddenPairStrategySolver(using: self)
        case .xWing:
            solver = XWingStrategySolver(using: self)
        case .uniqueRectangleType1:
            solver = UniqueRectangleType1StrategySolver(using: self)
        }
        
        guard let move = solver.solve() else {
            return false
        }
        
        for location in move.locations {
            let row = location.row
            let column = location.column
            let addedValue = location.addedValue
            let index = location.row * 9 + location.column
            
            if addedValue == 0 {
                for removedCandidate in location.removedCandidates {
                    self.candidates[index].removeAll { $0 == removedCandidate }
                }
            } else {
                self.candidates[index].removeAll()
                self.removeCandidates(row: row, column: column, n: addedValue)
                self.grid.cells[index] = addedValue
            }
        }
        
        self.moves.append(move)
        return true
    }
}
