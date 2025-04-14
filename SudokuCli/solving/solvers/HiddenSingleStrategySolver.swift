//
//  HiddenSingleStrategySolver.swift
//  SudokuCli
//
//  Created by Christopher Shipstone on 03/04/2025.
//

internal struct HiddenSingleStrategySolver: StrategySolver {
    private let solver: StrategicSudokuSolver
    
    internal init(using solver: StrategicSudokuSolver) {
        self.solver = solver
    }
    
    internal func solve() -> SudokuSolverMove? {
        guard let move = self.solveRow() else {
            guard let move = self.solveColumn() else {
                return self.solveBlock()
            }
            
            return move
        }
        
        return move
    }
    
    private func solveBlock() -> SudokuSolverMove? {
        for blockRow in stride(from: 0, to: 9, by: 3) {
            for blockColumn in stride(from: 0, to: 9, by: 3) {
                for n in 1...9 {
                    if let (row, column) = self.solveBlock(blockRow, blockColumn, n) {
                        let location = SudokuSolverMoveLocation(row, column, n)
                        return SudokuSolverMove(.hiddenSingle, location)
                    }
                }
            }
        }
        
        return nil
    }
    
    private func solveBlock(_ blockRow: Int, _ blockColumn: Int, _ n: Int) -> (Int, Int)? {
        var emptyIndex: (Int, Int)?
        
        for rowOffset in 0..<3 {
            for columnOffset in 0..<3 {
                let row = blockRow + rowOffset
                let column = blockColumn + columnOffset
                let index = row * 9 + column
                let candidates = solver.candidates[index]
                
                if candidates.contains(n) {
                    guard emptyIndex == nil else {
                        return nil
                    }
                    
                    emptyIndex = (row, column)
                }
            }
        }
        
        return emptyIndex
    }
    
    private func solveColumn() -> SudokuSolverMove? {
        for column in 0..<9 {
            for n in 1...9 {
                var emptyRow: Int?
                
                for row in 0..<9 {
                    let index = row * 9 + column
                    let candidates = solver.candidates[index]
                    
                    if candidates.contains(n) {
                        guard emptyRow == nil else {
                            emptyRow = nil
                            break
                        }
                        
                        emptyRow = row
                    }
                }
                
                if let row = emptyRow {
                    let location = SudokuSolverMoveLocation(row, column, n)
                    return SudokuSolverMove(.hiddenSingle, location)
                }
            }
        }
        
        return nil
    }
    
    private func solveRow() -> SudokuSolverMove? {
        for row in 0..<9 {
            for n in 1...9 {
                var emptyColumn: Int?
                
                for column in 0..<9 {
                    let index = row * 9 + column
                    let candidates = solver.candidates[index]
                    
                    if candidates.contains(n) {
                        guard emptyColumn == nil else {
                            emptyColumn = nil
                            break
                        }
                        
                        emptyColumn = column
                    }
                }
                
                if let column = emptyColumn {
                    let location = SudokuSolverMoveLocation(row, column, n)
                    return SudokuSolverMove(.hiddenSingle, location)
                }
            }
        }
        
        return nil
    }
}
