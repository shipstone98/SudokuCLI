//
//  Sudoku+GetCandidates.swift
//  SudokuCli
//
//  Created by Christopher Shipstone on 25/06/2025.
//

internal extension Sudoku {
    private func blockContains(_ row: Int, _ column: Int, _ n: Int) -> Bool {
        let blockRow = row - row % 3
        let blockColumn = column - column % 3
        
        for rowOffset in 0..<3 {
            for columnOffset in 0..<3 {
                if self[(blockRow + rowOffset), blockColumn + columnOffset] == n {
                    return true
                }
            }
        }
        
        return false
    }
    
    private func columnContains(_ column: Int, _ n: Int) -> Bool {
        for row in 0..<9 {
            guard self[row, column] != n else {
                return true
            }
        }
        
        return false
    }
    
    func getCandidates(_ row: Int, _ column: Int) -> [Int] {
        guard self[row, column] == 0 else {
            return []
        }
        
        var candidates: [Int] = []
        
        for n in 1...9 {
            if !(
                self.rowContains(row, n)
                || self.columnContains(column, n)
                || self.blockContains(row, column, n)
            ) {
                candidates.append(n)
            }
        }
        
        return candidates
    }
    
    private func rowContains(_ row: Int, _ n: Int) -> Bool {
        for column in 0..<9 {
            guard self[row, column] != n else {
                return true
            }
        }
        
        return false
    }
}
