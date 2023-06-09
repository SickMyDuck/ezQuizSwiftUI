//
//  InformationView.swift
//  ezQuiz
//
//  Created by Ruslan Sadritdinov on 24.04.2023.
//

import SwiftUI

struct InformationView: View {

    let gameType: GameType

    var body: some View {
        VStack{
            Text("Rules are simple:")
                .font(.headline)
                .padding(Paddings.large)
            if gameType == .flagGame {
                Text("You need to guess which country the flag on the screen belongs to.\n\nThere is one hint that eliminates two wrong answers.\n\nYou have 30 seconds to answer each question.\n\nThere are a total of 10 flags, and the difficulty depends on the level you choose.")
                    .font(Fonts.roboto)
            } else {
                Text("You need to guess which flag the country on the screen belongs to.\n\nThere is one hint that eliminates two wrong answers.\n\nYou have 30 seconds to answer each question.\n\nThere are a total of 10 countries, and the difficulty depends on the level you choose.")
                    .font(Fonts.roboto)
            }
            Text("If you answer correctly, the button will light up green. Otherwise, it will light up red, and the correct answer will be highlighted in green.\n\nGood luck!")
                .font(Fonts.roboto)
            Spacer()
        }
    }

}

struct InformationView_Previews: PreviewProvider {
    static var previews: some View {
        InformationView(gameType: .flagGame)
    }
}
