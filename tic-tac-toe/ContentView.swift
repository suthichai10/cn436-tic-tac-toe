//
//  ContentView.swift
//  tic-tac-toe
//
//  Created by Suthichai Chukaew on 27/8/2564 BE.
//

import SwiftUI

struct ContentView: View {
    @State private var moves : [Move?] = Array(repeating: nil, count: 9)
    @State private var alertItem : AlertItem?
    @State private var isGameDisabled = false
    @State private var score = 0
    @State private var startTurn = Player.human // Player turn first

    var body: some View {
        NavigationView {
            LazyVGrid(columns:[GridItem(),GridItem(),GridItem()]) {
                ForEach(0..<9) { i in
                    ZStack {
                        Color.blue
                            .opacity(0.5)
                            .frame(width:squareSize(),height:squareSize())
                            .cornerRadius(15)
                        Image(systemName: moves[i]?.mark ?? "xmark.circle")
                            .resizable()
                            .frame(width:markSize() , height: markSize())
                            .foregroundColor(.white)
                            .opacity((moves[i] == nil) ? 0 : 1)
                    }
                    .onTapGesture {
                        if isSquareOccupied(in: moves, forIndex: i) { return }
                        moves[i] = Move(player: .human, boardIndex: i)
                        isGameDisabled.toggle()
                        if checkWinCondition(for: .human, in: moves) {
                            alertItem = AlertContext.humanWin
                            score += 1
                            return
                        }
                        if checkForDraw(in: moves) {
                            alertItem = AlertContext.draw
                            return
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            let computerPosition = determineComputerMove(in: moves)
                            moves[computerPosition] = Move(player: .computer, boardIndex: computerPosition)
                            isGameDisabled.toggle()
                            if checkWinCondition(for: .computer, in: moves) {
                                alertItem = AlertContext.computerWin
                                return
                            }
                            if checkForDraw(in: moves) {
                                alertItem = AlertContext.draw
                            }
                        }
                    }
                }
            }
            .navigationTitle(Text("Tic Tac Toe"))
            .disabled(isGameDisabled)
            .padding()
            .alert(item:$alertItem) { alertItem in
                Alert(title:Text(alertItem.title) , message: Text(alertItem.message) , dismissButton: .default(Text(alertItem.buttonTitle), action: resetGame))
            }
        }
        Text("Score : \(score)")
            .padding()
            .font(.title)
    }
    
    func resetGame() {
        moves = Array(repeating: nil, count: 9)
        isGameDisabled = true
        startTurn = (startTurn == .human) ? .computer : .human
        if startTurn == .computer {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                let computerPosition = determineComputerMove(in: moves)
                moves[computerPosition] = Move(player: .computer, boardIndex: computerPosition)
            }
        }
        isGameDisabled.toggle()

    }
    
    func squareSize() -> CGFloat {
        UIScreen.main.bounds.width / 3 - 15
    }
    func markSize() -> CGFloat {
        squareSize() / 2
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
