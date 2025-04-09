//
//  Sudoku.swift
//  SudokuCli
//
//  Created by Christopher Shipstone on 01/04/2025.
//

public protocol Sudoku {
    subscript(row: Int, column: Int) -> Int { get }
}
