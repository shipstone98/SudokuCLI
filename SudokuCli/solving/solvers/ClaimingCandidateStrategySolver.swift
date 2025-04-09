//
//  ClaimingCandidateStrategySolver.swift
//  SudokuCli
//
//  Created by Christopher Shipstone on 04/04/2025.
//

internal struct ClaimingCandidateStrategySolver: StrategySolver {
    private let solver: StrategicSudokuSolver
    
    internal init(solver: StrategicSudokuSolver) {
        self.solver = solver
    }
    
    internal func solve() -> SudokuSolverMove? {
        guard let move = self.solveRow() else {
            return self.solveColumn()
        }
        
        return move
    }
    
    private func solve(_ n: Int, _ indices: [(Int, Int)]) -> SudokuSolverMove? {
        guard indices.count > 0 else {
            return nil
        }
        
        var locations: [SudokuSolverMoveLocation] = []
        
        for (currentRow, currentColumn) in indices {
            let location =
                SudokuSolverMoveLocation(currentRow, currentColumn, 0, n)
            
            locations.append(location)
        }
        
        return SudokuSolverMove(.claimingCandidate, locations)
    }
    
    private func solveColumn() -> SudokuSolverMove? {
        for column in 0..<9 {
            for n in 1...9 {
                var blockRows = Set<Int>()
                
                for row in 0..<9 {
                    let index = row * 9 + column
                    
                    if self.solver.candidates[index].contains(n) {
                        blockRows.insert(row - row % 3)
                    }
                }
                
                if blockRows.count == 1 {
                    let blockRow = blockRows.first!
                    let blockColumn = column - column % 3
                    var indices: [(Int, Int)] = []
                    
                    for columnOffset in 0..<3 {
                        let currentColumn = blockColumn + columnOffset
                        
                        guard column != currentColumn else {
                            continue
                        }
                        
                        for rowOffset in 0..<3 {
                            let currentRow = blockRow + rowOffset
                            let currentIndex = currentRow * 9 + currentColumn
                            
                            if self.solver.candidates[currentIndex].contains(n) {
                                indices.append((currentRow, currentColumn))
                            }
                        }
                    }
                    
                    if let move = self.solve(n, indices) {
                        return move
                    }
                }
            }
        }
        
        return nil
    }
    
    private func solveRow() -> SudokuSolverMove? {
        for row in 0..<9 {
            for n in 1...9 {
                var blockColumns = Set<Int>()
                
                for column in 0..<9 {
                    let index = row * 9 + column
                    
                    if self.solver.candidates[index].contains(n) {
                        blockColumns.insert(column - column % 3)
                    }
                }
                
                if blockColumns.count == 1 {
                    let blockRow = row - row % 3
                    let blockColumn = blockColumns.first!
                    var indices: [(Int, Int)] = []
                    
                    for rowOffset in 0..<3 {
                        let currentRow = blockRow + rowOffset
                        
                        guard row != currentRow else {
                            continue
                        }
                        
                        for columnOffset in 0..<3 {
                            let currentColumn = blockColumn + columnOffset
                            let currentIndex = currentRow * 9 + currentColumn
                            
                            if self.solver.candidates[currentIndex].contains(n) {
                                indices.append((currentRow, currentColumn))
                            }
                        }
                    }
                    
                    if let move = self.solve(n, indices) {
                        return move
                    }
                }
            }
        }
        
        return nil
    }
}
