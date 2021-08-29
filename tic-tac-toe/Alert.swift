//
//  AlertItem.swift
//  tic-tac-toe
//
//  Created by Suthichai Chukaew on 28/8/2564 BE.
//

import SwiftUI

struct AlertItem : Identifiable {
    let id = UUID()
    let title : String
    let message : String
    let buttonTitle : String
}

struct AlertContext {
    static let humanWin = AlertItem(title: "You Win!", message: "You are so smart 💪", buttonTitle: "Hell Yeah")
    static let draw = AlertItem(title: "Draw", message: "What a battle 🥁", buttonTitle: "Try again")
    static let computerWin = AlertItem(title: "You Lost!", message: "Better luck next time", buttonTitle: "Rematch")
}
