//
//  FlagView.swift
//  ezQuiz
//
//  Created by Ruslan Sadritdinov on 08.04.2023.
//

import SwiftUI
import Combine

struct FlagsView: View {

    @ObservedObject var viewModel = FlagsViewModel()

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        VStack {
            HStack {
                Text("Finished!")
                    .foregroundColor(.white)
                    .opacity(viewModel.isQuizFinished ? 1 : 0)
                Spacer()
                Text(String(viewModel.correctAnswersCounter))
                    .foregroundColor(.white)
                    .frame(alignment: .center)
            }
            Spacer()
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.white)
                    .frame(width: 250, height: 160)
                Image(uiImage: viewModel.flagImage)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 240, height: 150)
            }
            .padding()

            Spacer()

            LazyVGrid(columns: columns) {
                ForEach(viewModel.answers, id: \.self) { answer in
                    Button(action: {
                        viewModel.checkAnswer(answer: answer)
                    }) {
                        Text(answer)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                    .disabled(viewModel.isAnswered)
                }
            }
            .padding(.bottom, Paddings.large)
        }
        .background(Color.black)
        .onAppear(perform: viewModel.onAppear)
    }
}

struct FlagsView_Previews: PreviewProvider {
    static var previews: some View {
        FlagsView()
    }
}
