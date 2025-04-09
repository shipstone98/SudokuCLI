//
//  FullHouseStrategySolver.swift
//  SudokuCli
//
//  Created by Christopher Shipstone on 01/04/2025.
//

internal struct FullHouseStrategySolver : StrategySolver {
    private let solver: StrategicSudokuSolver
    
    internal init(solver: StrategicSudokuSolver) {
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
                if let (row, column) = self.solveBlock(blockRow, blockColumn) {
                    let candidates = solver.candidates[row * 9 + column]
                    
                    if candidates.count == 1 {
                        let location =
                            SudokuSolverMoveLocation(
                                row,
                                column,
                                candidates[0]
                            )
                        
                        return SudokuSolverMove(.fullHouse, location)
                    }
                }
            }
        }
        
        return nil
    }
    
    private func solveBlock(_ blockRow: Int, _ blockColumn: Int) -> (Int, Int)? {
        var emptyIndex: (Int, Int)? = nil
        
        for rowOffset in 0..<3 {
            for columnOffset in 0..<3 {
                let row = blockRow + rowOffset
                let column = blockColumn + columnOffset
                
                if self.solver.grid.cells[row * 9 + column] == 0 {
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
            var emptyRow: Int?
            
            for row in 0..<9 {
                if self.solver.grid.cells[row * 9 + column] == 0 {
                    guard emptyRow == nil else {
                        emptyRow = nil
                        break
                    }
                    
                    emptyRow = row
                }
            }
            
            if let row = emptyRow {
                let candidates = solver.candidates[row * 9 + column]
                
                if candidates.count == 1 {
                    let location =
                        SudokuSolverMoveLocation(row, column, candidates[0])
                    
                    return SudokuSolverMove(.fullHouse, location)
                }
            }
        }
        
        return nil
    }
    
    private func solveRow() -> SudokuSolverMove? {
        for row in 0..<9 {
            var emptyColumn: Int?
            
            for column in 0..<9 {
                if self.solver.grid.cells[row * 9 + column] == 0 {
                    guard emptyColumn == nil else {
                        emptyColumn = nil
                        break
                    }
                    
                    emptyColumn = column
                }
            }
            
            if let column = emptyColumn {
                let candidates = solver.candidates[row * 9 + column]
                
                if candidates.count == 1 {
                    let location =
                        SudokuSolverMoveLocation(row, column, candidates[0])
                    
                    return SudokuSolverMove(.fullHouse, location)
                }
            }
        }
        
        return nil
    }
}
