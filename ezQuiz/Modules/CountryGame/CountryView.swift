//
//  CountryView.swift
//  ezQuiz
//
//  Created by Ruslan Sadritdinov on 09.05.2023.
//


import SwiftUI
import Combine

struct CountryView: View {

    @ObservedObject var viewModel: CountryViewModel

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        ZStack{
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
                .padding(.top, Paddings.medium)

                TimerView(with: viewModel)

                Spacer()

                Text(viewModel.country ?? "")
                    .font(Fonts.italicBig)

                Spacer()

                LazyVGrid(columns: columns) {
                    ForEach($viewModel.answers, id: \.self) { answer in
                        Button(action: {
                            viewModel.checkAnswer(answer.answer.wrappedValue)
                        }) {
                            Image(uiImage: answer.image.wrappedValue)
                                .resizable()
                                .scaledToFit()
                        }
                        .background(
                            viewModel.getButtonColor(for: answer.answer.wrappedValue)
                        )
                        .padding(.horizontal, Paddings.large)
                        .padding(.bottom, Paddings.medium)
                        .buttonStyle(MainButtonStyle())
                        .disabled(viewModel.isAnswered || !viewModel.isButtonAvailable(for: answer.answer.wrappedValue))
                        .opacity(viewModel.isButtonAvailable(for: answer.answer.wrappedValue) ? 1 : 0)
                        .animation(viewModel.shouldAnimate ? .easeInOut(duration: 0.5) : .none)
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
                    .preferredColorScheme(.dark)
                    .padding(Paddings.small)
            }
            .navigationBarBackButtonHidden(true)
            .onAppear(perform: viewModel.onAppear)

            if viewModel.isMenuVisible {
                PauseView(viewModel: viewModel)
            }
        }
    }
}

struct CountryView_Previews: PreviewProvider {
    static var previews: some View {
        CountryView(viewModel: CountryViewModel())
    }
}
