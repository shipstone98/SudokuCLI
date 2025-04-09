//
//  Sudoku+print.swift
//  SudokuCli
//
//  Created by Christopher Shipstone on 03/04/2025.
//

public extension Sudoku {
    func print() -> String {
        let line = String(repeating: "-", count: 25)
        let newLine = "\n"
        var s = ""
        
        for row in 0..<9 {
            if row % 3 == 0 {
                s.append(line)
                s.append(newLine)
            }
            
            for column in 0..<9 {
                if column % 3 == 0 {
                    s.append("| ")
                }
                
                let value = self[row, column]
                
                if value == 0 {
                    s.append("  ")
                } else {
                    let valueString = String(value)
                    s.append(valueString)
                    s.append(" ")
                }
            }
            
            s.append("|")
            s.append(newLine)
        }
        
        s.append(line)
        return s
    }
}
