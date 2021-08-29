//
//  Game.swift
//  tic-tac-toe
//
//  Created by Suthichai Chukaew on 28/8/2564 BE.
//

import SwiftUI

enum Player {
    case human , computer
}

struct Move {
    let player : Player
    let boardIndex : Int
    
    var mark : String {
        player == .human ? "xmark" : "circle"
    }
}

func isSquareOccupied(in moves: [Move?] ,forIndex index: Int) -> Bool {
    moves[index] != nil
}

func checkWinCondition(for player: Player , in moves: [Move?]) -> Bool {
    let winPatterns : Array<Set<Int>> = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]
    
    let playerPosition = Set(moves.compactMap {$0}
                                .filter {$0.player == player}
                                .map { $0.boardIndex })
    
    for pattern in winPatterns {
        if pattern.isSubset(of: playerPosition) {
            return true
        }
    }
    return false
}

func checkForDraw(in moves: [Move?]) -> Bool {
    moves.compactMap { $0 }.count == 9
}

func determineComputerMove(in moves: [Move?]) -> Int {
    let winPatterns : Array<Set<Int>> = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]
    // If AI can win
    let computerPositions = Set(moves.compactMap { $0 }
                                    .filter { $0.player == .computer }
                                    .map { $0.boardIndex })
    for pattern in winPatterns {
        let winPositions = pattern.subtracting(computerPositions)
        if winPositions.count == 1 {
            if !isSquareOccupied(in: moves, forIndex: winPositions.first!) {
                return winPositions.first!

            }
        }
    }
    
    //If AI can't win, then blocks
    let humanPositions = Set(moves.compactMap { $0 }
                                    .filter { $0.player == .human }
                                    .map { $0.boardIndex })
    for pattern in winPatterns {
        let blockPositions = pattern.subtracting(humanPositions)
        if blockPositions.count == 1 {
            if !isSquareOccupied(in: moves, forIndex: blockPositions.first!) {
                return blockPositions.first!
            }
        }
    }
    
    // If Al can't block then take middle square
    let middlePosition = 4
    if !isSquareOccupied(in: moves, forIndex: middlePosition) {
        return middlePosition
    }
    
    // If Al can't take middle square , then take random available square
    var movePosition = Int.random(in:0..<9)
    
    while isSquareOccupied(in: moves, forIndex: movePosition) {
        movePosition = Int.random(in:0..<9)
    }
    return movePosition
}
