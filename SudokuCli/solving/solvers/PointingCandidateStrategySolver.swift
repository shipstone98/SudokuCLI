//
//  PointingCandidateStrategySolver.swift.swift
//  SudokuCli
//
//  Created by Christopher Shipstone on 04/04/2025.
//

internal struct PointingCandidateStrategySolver: StrategySolver {
    private let solver: StrategicSudokuSolver
    
    internal init(solver: StrategicSudokuSolver) {
        self.solver = solver
    }
    
    internal func solve() -> SudokuSolverMove? {
        for blockRow in stride(from: 0, to: 9, by: 3) {
            for blockColumn in stride(from: 0, to: 9, by: 3) {
                for n in 1...9 {
                    var rows = Set<Int>()
                    var columns = Set<Int>()
                    
                    for rowOffset in 0..<3 {
                        for columnOffset in 0..<3 {
                            let row = blockRow + rowOffset
                            let column = blockColumn + columnOffset
                            let index = row * 9 + column
                            
                            if self.solver.candidates[index].contains(n) {
                                rows.insert(row)
                                columns.insert(column)
                            }
                        }
                    }
                    
                    if rows.count == 1 {
                        if let move = self.solveRows(
                            n: n,
                            row: rows.first!,
                            blockColumn: blockColumn
                        ) {
                            return move
                        }
                    }
                    
                    if columns.count == 1 {
                        if let move = self.solveColumns(
                            n: n,
                            column: columns.first!,
                            blockRow: blockRow
                        ) {
                            return move
                         }
                    }
                }
            }
        }
        
        return nil
    }
    
    private func solveColumns(n: Int, column: Int, blockRow: Int) -> SudokuSolverMove? {
        var rows = Set<Int>()
        
        for row in 0..<9 {
            let delta = row - blockRow
            
            guard !(delta < 3 && delta > -1) else {
                continue
            }
            
            let index = row * 9 + column
            
            if self.solver.candidates[index].contains(where: { $0 == n }) {
                rows.insert(row)
            }
        }
        
        guard rows.count == 0 else {
            var locations: [SudokuSolverMoveLocation] = []
            
            for row in rows {
                let location =
                    SudokuSolverMoveLocation(row, column, 0, n)
                
                locations.append(location)
            }
            
            return SudokuSolverMove(.pointingCandidate, locations)
        }
        
        return nil
    }
    
    private func solveRows(n: Int, row: Int, blockColumn: Int) -> SudokuSolverMove? {
        var columns = Set<Int>()
        
        for column in 0..<9 {
            let delta = column - blockColumn
            
            guard !(delta < 3 && delta > -1) else {
                continue
            }
            
            let index = row * 9 + column
            
            if self.solver.candidates[index].contains(where: { $0 == n }) {
                columns.insert(column)
            }
        }
        
        guard columns.count == 0 else {
            var locations: [SudokuSolverMoveLocation] = []
            
            for column in columns {
                let location =
                    SudokuSolverMoveLocation(row, column, 0, n)
                
                locations.append(location)
            }
            
            return SudokuSolverMove(.pointingCandidate, locations)
        }
        
        return nil
    }
}
