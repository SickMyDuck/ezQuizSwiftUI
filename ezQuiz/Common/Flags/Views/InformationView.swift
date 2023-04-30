//
//  InformationView.swift
//  ezQuiz
//
//  Created by Ruslan Sadritdinov on 24.04.2023.
//

import SwiftUI

struct InformationView: View {
    var body: some View {
        VStack{
            Text("Rules are simple:")
                .font(.headline)
                .padding(Paddings.large)
            Text("You need to guess which country the flag on the screen belongs to.\nThere is one hint that eliminates two wrong answers.\nYou have 30 seconds to answer each question.\nThere are a total of 10 flags, and the difficulty depends on the level you choose.\nIf you answer correctly, the button will light up green. Otherwise, it will light up red, and the correct answer will be highlighted in green. Good luck!")
            Image("FlagExample")
                .resizable()
                .scaledToFit()
                .frame(width: UIScreen.main.bounds.width / 2, height: UIScreen.main.bounds.width
                       / 2)
            Text("")
            Spacer()
        }
    }

}

struct InformationView_Previews: PreviewProvider {
    static var previews: some View {
        InformationView()
    }
}
