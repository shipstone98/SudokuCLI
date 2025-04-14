//
//  HiddenPairStrategySolver.swift
//  SudokuCli
//
//  Created by Christopher Shipstone on 14/04/2025.
//

internal struct HiddenPairStrategySolver: StrategySolver {
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
                for n1 in 1...8 {
                    for n2 in (n1 + 1)...9 {
                        var n1Indices: [Int] = []
                        var n2Indices: [Int] = []
                        
                        for rowOffset in 0..<3 {
                            for columnOffset in 0..<3 {
                                let index =
                                    (blockRow + rowOffset) * 3 + blockColumn + columnOffset
                                
                                if self.solver.candidates[index].contains(n1) {
                                    n1Indices.append(index)
                                }
                                
                                if self.solver.candidates[index].contains(n2) {
                                    n2Indices.append(index)
                                }
                            }
                        }
                        
                        if n1Indices.count == 2 && n1Indices == n2Indices {
                            let index1 = n1Indices[0]
                            let index2 = n2Indices[1]
                            var locations: [SudokuSolverMoveLocation] = []
                            let predicate = { !($0 == n1 || $0 == n2) }
                            
                            let index1Candidates =
                                self.solver.candidates[index1].filter(predicate)
                            
                            let index2Candidates =
                                self.solver.candidates[index2].filter(predicate)
                            
                            if !index1Candidates.isEmpty {
                                let location =
                                SudokuSolverMoveLocation(
                                    index1 / 9,
                                    index1 % 9,
                                    0,
                                    index1Candidates
                                )
                                
                                locations.append(location)
                            }
                            
                            if !index2Candidates.isEmpty {
                                let location =
                                SudokuSolverMoveLocation(
                                    index2 / 9,
                                    index2 % 9,
                                    0,
                                    index2Candidates
                                )
                                
                                locations.append(location)
                            }
                            
                            guard locations.isEmpty else {
                                return SudokuSolverMove(.hiddenPair, locations)
                            }
                        }
                    }
                }
            }
        }
        
        return nil
    }
    
    private func solveColumn() -> SudokuSolverMove? {
        for column in 0..<9 {
            for n1 in 1...8 {
                for n2 in (n1 + 1)...9 {
                    var n1Rows: [Int] = []
                    var n2Rows: [Int] = []
                    
                    for row in 0..<9 {
                        let index = row * 9 + column
                        
                        if self.solver.candidates[index].contains(n1) {
                            n1Rows.append(row)
                        }
                        
                        if self.solver.candidates[index].contains(n2) {
                            n2Rows.append(row)
                        }
                    }
                    
                    if n1Rows.count == 2 && n1Rows == n2Rows {
                        let row1 = n1Rows[0]
                        let row2 = n2Rows[1]
                        var locations: [SudokuSolverMoveLocation] = []
                        let predicate = { !($0 == n1 || $0 == n2) }
                        
                        let row1Candidates =
                            self.solver.candidates[row1 * 9 + column].filter(predicate)
                        
                        let row2Candidates =
                            self.solver.candidates[row2 * 9 + column].filter(predicate)
                        
                        if !row1Candidates.isEmpty {
                            let location =
                                SudokuSolverMoveLocation(
                                    row1,
                                    column,
                                    0,
                                    row1Candidates
                                )
                            
                            locations.append(location)
                        }
                        
                        if !row2Candidates.isEmpty {
                            let location =
                                SudokuSolverMoveLocation(
                                    row2,
                                    column,
                                    0,
                                    row2Candidates
                                )
                            
                            locations.append(location)
                        }
                        
                        guard locations.isEmpty else {
                            return SudokuSolverMove(.hiddenPair, locations)
                        }
                    }
                }
            }
        }
        
        return nil
    }
    
    private func solveRow() -> SudokuSolverMove? {
        for row in 0..<9 {
            for n1 in 1...8 {
                for n2 in (n1 + 1)...9 {
                    var n1Columns: [Int] = []
                    var n2Columns: [Int] = []
                    
                    for column in 0..<9 {
                        let index = row * 9 + column
                        
                        if self.solver.candidates[index].contains(n1) {
                            n1Columns.append(column)
                        }
                        
                        if self.solver.candidates[index].contains(n2) {
                            n2Columns.append(column)
                        }
                    }
                    
                    if n1Columns.count == 2 && n1Columns == n2Columns {
                        let column1 = n1Columns[0]
                        let column2 = n2Columns[1]
                        var locations: [SudokuSolverMoveLocation] = []
                        let predicate = { !($0 == n1 || $0 == n2) }
                        
                        let column1Candidates =
                            self.solver.candidates[row * 9 + column1].filter(predicate)
                        
                        let column2Candidates =
                            self.solver.candidates[row * 9 + column2].filter(predicate)
                        
                        if !column1Candidates.isEmpty {
                            let location =
                                SudokuSolverMoveLocation(
                                    row,
                                    column1,
                                    0,
                                    column1Candidates
                                )
                            
                            locations.append(location)
                        }
                        
                        if !column2Candidates.isEmpty {
                            let location =
                                SudokuSolverMoveLocation(
                                    row,
                                    column2,
                                    0,
                                    column2Candidates
                                )
                            
                            locations.append(location)
                        }
                        
                        guard locations.isEmpty else {
                            return SudokuSolverMove(.hiddenPair, locations)
                        }
                    }
                }
            }
        }
        
        return nil
    }
}
