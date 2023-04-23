//
//  FlagView.swift
//  ezQuiz
//
//  Created by Ruslan Sadritdinov on 08.04.2023.
//

import SwiftUI
import Combine
struct FlagsView: View {

    @ObservedObject var viewModel: FlagsViewModel

    let columns = [
        GridItem(.flexible())
    ]

    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Text("Correct answers:  \(viewModel.correctAnswersCounter)")
                        .foregroundColor(.green)
                        .font(.headline)
                    Spacer()
                    Text("Question \(viewModel.questionsCounter + (viewModel.questionsCounter == 10 ? 0 : 1))")
                        .foregroundColor(.white)
                        .font(.headline)

                }
                .padding(Paddings.large)

                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.gray)
                        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width * (viewModel.flagImage.size.height / viewModel.flagImage.size.width))
                    Image(uiImage: viewModel.flagImage)
                        .resizable()
                        .scaledToFit()
                        .frame(width: UIScreen.main.bounds.width - 20, height: UIScreen.main.bounds.width * (viewModel.flagImage.size.height / viewModel.flagImage.size.width) - 20)
                }
                .padding()


                Spacer()

                LazyVGrid(columns: columns) {
                    ForEach(viewModel.answers, id: \.self) { answer in
                        Button(action: {
                            viewModel.checkAnswer(answer: answer)
                        }) {
                            Text(answer)
                        }
                        .background(
                            (answer == viewModel.correctAnswer && viewModel.selectedAnswer == answer) ? Color.green : ((viewModel.selectedAnswer == answer) ? Color.red : Color.clear)
                        )
                        .padding(.horizontal, Paddings.large)
                        .padding(.bottom, Paddings.medium)
                        .buttonStyle(MainButtonStyle())
                        .disabled(viewModel.isAnswered)


                    }
                }
                .padding(.bottom, Paddings.large)
            }
            .navigationBarItems(leading: Button {
                viewModel.isMenuVisible.toggle()
            } label: {
                Image(systemName: "info.circle")
                    .resizable()
                    .frame(width: 30, height: 30)
            }
                .frame(alignment: .trailing)
                .padding(Paddings.large)
                .foregroundColor(.white)
            )
            .navigationBarItems(trailing:
                                    Button {
                viewModel.isMenuVisible.toggle()
            } label: {
                Image(systemName: "pause.circle")
                    .resizable()
                    .frame(width: 30, height: 30)
            }
                .frame(alignment: .trailing)
                .padding(Paddings.large)
                .foregroundColor(.white)
            )
            .navigationBarBackButtonHidden(true)
            .onAppear(perform: viewModel.onAppear)

            if viewModel.isMenuVisible {
                PauseView(viewModel: viewModel)
            }
        }
    }
}

struct FlagsView_Previews: PreviewProvider {
    static var previews: some View {
        FlagsView(viewModel: FlagsViewModel())
    }
}
