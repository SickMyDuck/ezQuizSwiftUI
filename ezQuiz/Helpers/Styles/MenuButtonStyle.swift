//
//  MenuButtonView.swift
//  ezQuiz
//
//  Created by Ruslan Sadritdinov on 22.04.2023.
//

import Foundation
import SwiftUI

struct MenuButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity, alignment: .center)
            .padding()
            .contentShape(Rectangle())
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.white, lineWidth: 3)
                    .background(Color.clear)
            )
    }
}
