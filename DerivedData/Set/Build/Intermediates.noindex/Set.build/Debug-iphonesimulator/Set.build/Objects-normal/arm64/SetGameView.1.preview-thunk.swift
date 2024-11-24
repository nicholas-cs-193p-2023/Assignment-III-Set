import func SwiftUI.__designTimeFloat
import func SwiftUI.__designTimeString
import func SwiftUI.__designTimeInteger
import func SwiftUI.__designTimeBoolean

#sourceLocation(file: "/Users/nicholasdalba/Developer/Set/Set/View/SetGameView.swift", line: 1)
//
//  ContentView.swift
//  Set
//
//  Created by Nicholas Alba on 8/24/24.
//

import SwiftUI

struct SetGameView: View {
    @ObservedObject var viewModel: SetGameViewModel
    
    var body: some View {
        cards
        buttons
    }
    
    var cards: some View {
        AspectVGrid(viewModel.cards, aspectRatio: Constants.aspectRatio, minimumGridItemWidth: Constants.minimumGridItemWidth) { card in
            cardView(card)
        }.padding()
    }
    
    @ViewBuilder
    func cardView(_ card: Card) -> some View {
        let selectionState = viewModel.selectionState(card)
        let fillColor =  Constants.cardBackgroundColors[selectionState]
        CardView(card: card, fillColor: fillColor)
            .padding(Constants.cardPadding)
            .onTapGesture {
            viewModel.choose(card)
        }
    }
    
    var buttons: some View {
        HStack {
            bottomButton(__designTimeString("#6292_0", fallback: "Start New Game")) {
                viewModel.startNewGame()
            }
            bottomButton(__designTimeString("#6292_1", fallback: "Deal More Cards"), disabled: viewModel.deckIsEmpty) {
                viewModel.dealMoreCards()
            }
        }
    }
    
    func bottomButton(_ text: String, disabled: Bool = false, _ action: @escaping () -> Void) -> some View {
        Button(text) {
            action()
        }.disabled(disabled)
            .fontWeight(.semibold)
            .padding(.horizontal)
    }
    
    private struct Constants {
        static let aspectRatio = CGFloat(2.5)/CGFloat(3.5)
        static let cardPadding = 4.0
        static let minimumGridItemWidth = 64.0
        static let cardBackgroundColors: [CardSelectionState?: Color] = [.selected: Color(hex: 0xedc400), .matched: Color(hex: 0x71b379), .mismatched: Color(hex: 0xb25690)]
    }
}

extension Color {
    init(hex: UInt, alpha: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xff) / 255,
            green: Double((hex >> 8) & 0xff) / 255,
            blue: Double(hex & 0xff) / 255,
            opacity: alpha
        )
    }
}

#Preview {
    SetGameView(viewModel: SetGameViewModel())
}
