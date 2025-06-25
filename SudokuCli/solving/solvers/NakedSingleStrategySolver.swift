//
//  NakedSingleStrategySolver.swift
//  SudokuCli
//
//  Created by Christopher Shipstone on 02/04/2025.
//

internal struct NakedSingleStrategySolver : StrategySolver {
    private let solver: StrategicSudokuSolver
    
    internal init(using solver: StrategicSudokuSolver) {
        self.solver = solver
    }
    
    internal func solve() -> SudokuSolverMove? {
        for row in 0..<9 {
            for column in 0..<9 {
                let index = row * 9 + column
                let candidates = solver.candidates[index]
                
                guard candidates.count == 1 else {
                    continue
                }
                
                let location = SudokuSolverMoveLocation(
                    row,
                    column,
                    candidates[0]
                )
                
                return SudokuSolverMove(.nakedSingle, location)
            }
        }
        
        return nil
    }
}
