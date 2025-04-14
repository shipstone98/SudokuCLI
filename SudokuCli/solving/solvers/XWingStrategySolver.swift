//
//  XWingStrategySolver.swift
//  SudokuCli
//
//  Created by Christopher Shipstone on 08/04/2025.
//

internal struct XWingStrategySolver : StrategySolver {
    private let solver: StrategicSudokuSolver
    
    internal init(using solver: StrategicSudokuSolver) {
        self.solver = solver
    }
    
    internal func solve() -> SudokuSolverMove? {
        guard let move = self.solveRow() else {
            return self.solveColumn()
        }
        
        return move
    }
    
    private func solveColumn() -> SudokuSolverMove? {
        for column1 in 0..<8 {
            for column2 in (column1 + 1)..<9 {
                for n in 1...9 {
                    var column1Rows: [Int] = []
                    var column2Rows: [Int] = []
                    
                    for row in 0..<9 {
                        if self.solver.candidates[row * 9 + column1].contains(n) {
                            column1Rows.append(row)
                        }
                        
                        if self.solver.candidates[row * 9 + column2].contains(n) {
                            column2Rows.append(row)
                        }
                    }
                    
                    guard column1Rows.count == 2 && column2Rows.count == 2 else {
                        continue
                    }
                    
                    let column1Row1 = column1Rows.first!
                    let column1Row2 = column1Rows.last!
                    let column2Row1 = column2Rows.first!
                    let column2Row2 = column2Rows.last!
                    
                    guard column1Row1 == column2Row1 && column1Row2 == column2Row2 else {
                        continue
                    }
                    
                    var locations: [SudokuSolverMoveLocation] = []
                    
                    for column in 0..<9 {
                        guard !(column == column1 || column == column2) else {
                            continue
                        }
                        
                        if self.solver.candidates[column1Row1 * 9 + column].contains(n) {
                            let location =
                                SudokuSolverMoveLocation(
                                    column1Row1,
                                    column,
                                    0,
                                    n
                                )
                            
                            locations.append(location)
                        }
                        
                        if self.solver.candidates[column1Row2 * 9 + column].contains(n) {
                            let location =
                                SudokuSolverMoveLocation(
                                    column1Row2,
                                    column,
                                    0,
                                    n
                                )
                            
                            locations.append(location)
                        }
                    }
                    
                    guard !locations.isEmpty else {
                        continue
                    }
                    
                    return SudokuSolverMove(.xWing, locations)
                }
            }
        }
        
        return nil
    }
    
    private func solveRow() -> SudokuSolverMove? {
        for row1 in 0..<8 {
            for row2 in (row1 + 1)..<9 {
                for n in 1...9 {
                    var row1Columns: [Int] = []
                    var row2Columns: [Int] = []
                    
                    for column in 0..<9 {
                        if self.solver.candidates[row1 * 9 + column].contains(n) {
                            row1Columns.append(column)
                        }
                        
                        if self.solver.candidates[row2 * 9 + column].contains(n) {
                            row2Columns.append(column)
                        }
                    }
                    
                    guard row1Columns.count == 2 && row2Columns.count == 2 else {
                        continue
                    }
                    
                    let row1Column1 = row1Columns.first!
                    let row1Column2 = row1Columns.last!
                    let row2Column1 = row2Columns.first!
                    let row2Column2 = row2Columns.last!
                    
                    guard row1Column1 == row2Column1 && row1Column2 == row2Column2 else {
                        continue
                    }
                    
                    var locations: [SudokuSolverMoveLocation] = []
                    
                    for row in 0..<9 {
                        guard !(row == row1 || row == row2) else {
                            continue
                        }
                        
                        if self.solver.candidates[row * 9 + row1Column1].contains(n) {
                            let location =
                                SudokuSolverMoveLocation(row, row1Column1, 0, n)
                            
                            locations.append(location)
                        }
                        
                        if self.solver.candidates[row * 9 + row1Column2].contains(n) {
                            let location =
                                SudokuSolverMoveLocation(row, row1Column2, 0, n)
                            
                            locations.append(location)
                        }
                    }
                    
                    guard !locations.isEmpty else {
                        continue
                    }
                    
                    return SudokuSolverMove(.xWing, locations)
                }
            }
        }
        
        return nil
    }
}
