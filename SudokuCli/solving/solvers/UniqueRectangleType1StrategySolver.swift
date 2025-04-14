//
//  UniqueRectangleType1StrategySolver.swift
//  SudokuCli
//
//  Created by Christopher Shipstone on 14/04/2025.
//

internal struct UniqueRectangleType1StrategySolver : StrategySolver {
    private let solver: StrategicSudokuSolver
    
    internal init(using solver: StrategicSudokuSolver) {
        self.solver = solver
    }
    
    internal func solve() -> SudokuSolverMove? {
        for row1 in 0..<8 {
            for row2 in (row1 + 1)..<9 {
                for n1 in 1...8 {
                    for n2 in (n1 + 1)...9 {
                        var row1Columns: [Int] = []
                        var row2Columns: [Int] = []
                        
                        for column in 0..<9 {
                            let index1 = row1 * 9 + column
                            let index2 = row2 * 9 + column
                            
                            if self.solver.candidates[index1].contains(n1)
                                && self.solver.candidates[index1].contains(n2) {
                                row1Columns.append(column)
                            }
                            
                            if self.solver.candidates[index2].contains(n1)
                                && self.solver.candidates[index2].contains(n2) {
                                row2Columns.append(column)
                            }
                        }
                        
                        if row1Columns.count == 2 && row1Columns == row2Columns {
                            let location = self.solve(
                                row1,
                                row2,
                                row1Columns[0],
                                row1Columns[1],
                                n1,
                                n2
                            )
                            
                            if let location = location {
                                return SudokuSolverMove(
                                    .uniqueRectangleType1,
                                    [location]
                                )
                            }
                        }
                    }
                }
            }
        }
        
        return nil
    }
    
    private func solve(
        _ row1: Int,
        _ row2: Int,
        _ column1: Int,
        _ column2: Int,
        _ n1: Int,
        _ n2: Int
    ) -> SudokuSolverMoveLocation? {
        var location: SudokuSolverMoveLocation?
        let removedCandidates = [n1, n2]
        
        let indices = [
            (row1, column1),
            (row1, column2),
            (row2, column1),
            (row2, column2)
        ]
        
        for (row, column) in indices {
            let count = self.solver.candidates[row * 9 + column].count{ !removedCandidates.contains($0) }
            
            guard count > 0 else {
                continue
            }
            
            guard location == nil else {
                return nil
            }
            
            location = SudokuSolverMoveLocation(
                row,
                column,
                0,
                removedCandidates
            )
        }
        
        return location
    }
}
