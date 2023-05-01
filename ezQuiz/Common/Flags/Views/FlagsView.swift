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
                .padding(.top, Paddings.large)

                TimerView(with: viewModel)

                Image(uiImage: viewModel.flagImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width * (viewModel.flagImage.size.height / viewModel.flagImage.size.width))
                    .padding(.vertical, Paddings.large)

                Spacer()

                LazyVGrid(columns: columns) {
                    ForEach(viewModel.answers, id: \.self) { answer in
                        Button(action: {
                            viewModel.checkAnswer(answer)
                        }) {
                            Text(answer)
                        }
                        .background(
                            viewModel.getButtonColor(for: answer)
                        )
                        .padding(.horizontal, Paddings.large)
                        .padding(.bottom, Paddings.medium)
                        .buttonStyle(MainButtonStyle())
                        .disabled(viewModel.isAnswered || !viewModel.isButtonAvailable(for: answer))
                        .opacity(viewModel.isButtonAvailable(for: answer) ? 1 : 0)
                        .animation(.easeInOut(duration: 0.5))
                    }
                }
                .padding(.bottom, Paddings.large)
            }
            .navigationBarItems(leading:
                Button {
                    viewModel.isHintUsed.toggle()
                } label: {
                    Image(systemName: "50.circle")
                        .resizable()
                        .frame(width: 30, height: 30)
                }
                .padding(Paddings.large)
                .foregroundColor(.white)
            )
            .navigationBarItems(trailing:
                                    HStack {
                Button {
                    viewModel.isInformationVisible.toggle()
                } label: {
                    Image(systemName: "info.circle")
                        .resizable()
                        .frame(width: 30, height: 30)
                } // Info
                .foregroundColor(.white)

                Button {
                    viewModel.isMenuVisible.toggle()
                } label: {
                    Image(systemName: "pause.circle")
                        .resizable()
                        .frame(width: 30, height: 30)
                } // Pause
                .frame(alignment: .trailing)
                .padding(Paddings.small)
                .foregroundColor(.white)
            }
            )
            .sheet(isPresented: $viewModel.isInformationVisible) {
                InformationView()
            }
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
