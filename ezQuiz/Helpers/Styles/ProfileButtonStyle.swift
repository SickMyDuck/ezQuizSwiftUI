//
//  ProfileButtonStyle.swift
//  ezQuiz
//
//  Created by Ruslan Sadritdinov on 22.04.2023.
//

import Foundation
import SwiftUI

struct ProfileButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(Paddings.small)
            .contentShape(Rectangle())
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.white, lineWidth: 2)
                    .background(Color.clear)
            )
    }
}
