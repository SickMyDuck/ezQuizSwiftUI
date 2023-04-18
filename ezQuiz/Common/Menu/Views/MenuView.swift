//
//  MenuView.swift
//  ezQuiz
//
//  Created by Ruslan Sadritdinov on 31.03.2023.
//

import SwiftUI
import Combine

import SwiftUI


struct MenuView: View {
    @ObservedObject var viewModel: MenuViewModel

    var body: some View {
        VStack(spacing: 16) {
            ForEach(viewModel.items, id: \.title) { item in
                Button(action: {
                    viewModel.navigateTo(destination: item.destination)
                }) {
                    Text(item.title)
                }
            }
        }
    }
}
