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

    // Определяем состояние меню
    @State private var isMenuVisible = false

    let columns = [
        GridItem(.flexible())
    ]

    var body: some View {
        ZStack {
            // Основное представление
            VStack {
                HStack {
                    Text("Finished!")
                        .font(Fonts.roboto)
                        .foregroundColor(.white)
                        .opacity(viewModel.isQuizFinished ? 1 : 0)
                        .animation(.easeInOut)
                    Spacer()
                    Button {
                    viewModel.isMenuVisible.toggle()
                    } label: {
                        Image(systemName: "pause.circle")
                    }
                    .frame(alignment: .trailing)
                    .padding(Paddings.large)
                    .foregroundColor(.white)

                }
                Spacer()
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.gray)
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
                                .foregroundColor(viewModel.buttonForegroundColor)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(viewModel.buttonBackgroundColor)
                                .cornerRadius(10)
                        }
                        .disabled(viewModel.isAnswered)
                    }
                }
                .padding(.bottom, Paddings.large)
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
