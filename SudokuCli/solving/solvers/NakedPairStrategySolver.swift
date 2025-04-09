//
//  NakedPairStrategySolver.swift
//  SudokuCli
//
//  Created by Christopher Shipstone on 08/04/2025.
//

internal struct NakedPairStrategySolver : StrategySolver {
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
                for n1 in 1..<9 {
                    for n2 in (n1 + 1)...9 {
                        var indices: [Int] = []
                        
                        for rowOffset in 0..<3 {
                            for columnOffset in 0..<3 {
                                let index =
                                    ((blockRow + rowOffset) * 9)
                                    + blockColumn + columnOffset
                                
                                let candidates = self.solver.candidates[index]
                                
                                if candidates.count == 2
                                    && candidates.contains(n1)
                                    && candidates.contains(n2) {
                                    indices.append(index)
                                }
                            }
                        }
                        
                        if indices.count == 2 {
                            if let move =
                                self.solveBlock(
                                    blockRow,
                                    blockColumn,
                                    indices.first!,
                                    indices.last!,
                                    n1,
                                    n2
                                ) {
                                return move
                            }
                        }
                    }
                }
            }
        }
        
        return nil
    }
    
    private func solveBlock(
        _ blockRow: Int,
        _ blockColumn: Int,
        _ index1: Int,
        _ index2: Int,
        _ n1: Int,
        _ n2: Int
    ) -> SudokuSolverMove? {
        var n1Indices: [Int] = []
        var n2Indices: [Int] = []
        
        for rowOffset in 0..<3 {
            for columnOffset in 0..<3 {
                let index =
                    (blockRow + rowOffset) * 9 + blockColumn + columnOffset
                
                guard !(index == index1 || index == index2) else {
                    continue
                }
                
                let candidates = self.solver.candidates[index]
                
                if candidates.contains(n1) {
                    n1Indices.append(index)
                }
                
                if candidates.contains(n2) {
                    n2Indices.append(index)
                }
            }
        }
        
        guard !(n1Indices.isEmpty && n2Indices.isEmpty) else {
            return nil
        }
        
        return self.solveBlockBuild(
            blockRow,
            blockColumn,
            n1,
            n2,
            n1Indices,
            n2Indices
        )
    }
    
    private func solveBlockBuild(
        _ blockRow: Int,
        _ blockColumn: Int,
        _ n1: Int,
        _ n2: Int,
        _ n1Indices: [Int],
        _ n2Indices: [Int]
    ) -> SudokuSolverMove {
        var locations: [SudokuSolverMoveLocation] = []
        
        for rowOffset in 0..<3 {
            for columnOffset in 0..<3 {
                var removedCandidates: [Int] = []
                let row = blockRow + rowOffset
                let column = blockColumn + columnOffset
                let index = row * 9 + column
                
                if n1Indices.contains(index) {
                    removedCandidates.append(n1)
                }
                
                if n2Indices.contains(index) {
                    removedCandidates.append(n2)
                }
                
                guard !removedCandidates.isEmpty else {
                    continue
                }
                
                let location =
                    SudokuSolverMoveLocation(
                        row,
                        column,
                        0,
                        removedCandidates
                    )
                
                locations.append(location)
            }
        }
        
        return SudokuSolverMove(.nakedPair, locations)
    }
    
    private func solveColumn() -> SudokuSolverMove? {
        for column in 0..<9 {
            for n1 in 1..<9 {
                for n2 in (n1 + 1)...9 {
                    var rows: [Int] = []
                    
                    for row in 0..<9 {
                        let index = row * 9 + column
                        let candidates = self.solver.candidates[index]
                        
                        if candidates.count == 2
                            && candidates.contains(n1)
                            && candidates.contains(n2) {
                            rows.append(row)
                        }
                    }
                    
                    if rows.count == 2 {
                        if let move =
                            self.solveColumn(
                                column,
                                rows.first!,
                                rows.last!,
                                n1,
                                n2
                            ) {
                            return move
                        }
                    }
                }
            }
        }
        
        return nil
    }
    
    private func solveColumn(
        _ column: Int,
        _ row1: Int,
        _ row2: Int,
        _ n1: Int,
        _ n2: Int
    ) -> SudokuSolverMove? {
        var n1Rows: [Int] = []
        var n2Rows: [Int] = []
        
        for row in 0..<9 {
            guard !(row == row1 || row == row2) else {
                continue
            }
            
            let index = row * 9 + column
            let candidates = self.solver.candidates[index]
            
            if candidates.contains(n1) {
                n1Rows.append(row)
            }
            
            if candidates.contains(n2) {
                n2Rows.append(row)
            }
        }
        
        guard !(n1Rows.isEmpty && n2Rows.isEmpty) else {
            return nil
        }
        
        return self.solveColumnBuild(column, n1, n2, n1Rows, n2Rows)
    }
    
    private func solveColumnBuild(
        _ column: Int,
        _ n1: Int,
        _ n2: Int,
        _ n1Rows: [Int],
        _ n2Rows: [Int]
    ) -> SudokuSolverMove {
        var locations: [SudokuSolverMoveLocation] = []
        
        for row in 0..<9 {
            var removedCandidates: [Int] = []
            
            if n1Rows.contains(row) {
                removedCandidates.append(n1)
            }
            
            if n2Rows.contains(row) {
                removedCandidates.append(n2)
            }
            
            guard !removedCandidates.isEmpty else {
                continue
            }
            
            let location =
                SudokuSolverMoveLocation(
                    row,
                    column,
                    0,
                    removedCandidates
                )
            
            locations.append(location)
        }
        
        return SudokuSolverMove(.nakedPair, locations)
    }
    
    private func solveRow() -> SudokuSolverMove? {
        for row in 0..<9 {
            for n1 in 1..<9 {
                for n2 in (n1 + 1)...9 {
                    var columns: [Int] = []
                    
                    for column in 0..<9 {
                        let index = row * 9 + column
                        let candidates = self.solver.candidates[index]
                        
                        if candidates.count == 2
                            && candidates.contains(n1)
                            && candidates.contains(n2) {
                            columns.append(column)
                        }
                    }
                    
                    if columns.count == 2 {
                        if let move =
                            self.solveRow(
                                row,
                                columns.first!,
                                columns.last!,
                                n1,
                                n2
                            ) {
                            return move
                        }
                    }
                }
            }
        }
        
        return nil
    }
    
    private func solveRow(
        _ row: Int,
        _ column1: Int,
        _ column2: Int,
        _ n1: Int,
        _ n2: Int
    ) -> SudokuSolverMove? {
        var n1Columns: [Int] = []
        var n2Columns: [Int] = []
        
        for column in 0..<9 {
            guard !(column == column1 || column == column2) else {
                continue
            }
            
            let index = row * 9 + column
            let candidates = self.solver.candidates[index]
            
            if candidates.contains(n1) {
                n1Columns.append(column)
            }
            
            if candidates.contains(n2) {
                n2Columns.append(column)
            }
        }
        
        guard !(n1Columns.isEmpty && n2Columns.isEmpty) else {
            return nil
        }
        
        return self.solveRowBuild(row, n1, n2, n1Columns, n2Columns)
    }
    
    private func solveRowBuild(
        _ row: Int,
        _ n1: Int,
        _ n2: Int,
        _ n1Columns: [Int],
        _ n2Columns: [Int]
    ) -> SudokuSolverMove {
        var locations: [SudokuSolverMoveLocation] = []
        
        for column in 0..<9 {
            var removedCandidates: [Int] = []
            
            if n1Columns.contains(column) {
                removedCandidates.append(n1)
            }
            
            if n2Columns.contains(column) {
                removedCandidates.append(n2)
            }
            
            guard !removedCandidates.isEmpty else {
                continue
            }
            
            let location =
                SudokuSolverMoveLocation(
                    row,
                    column,
                    0,
                    removedCandidates
                )
            
            locations.append(location)
        }
        
        return SudokuSolverMove(.nakedPair, locations)
    }
}
