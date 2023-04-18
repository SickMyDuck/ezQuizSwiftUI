//
//  AboutView.swift
//  ezQuiz
//
//  Created by Ruslan Sadritdinov on 18.04.2023.
//

import Foundation
import SwiftUI

struct AboutView: View {
    @ObservedObject var viewModel: AboutViewModel = AboutViewModel()
   // @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView {
            VStack {
                Text("О нас")
                    .font(.largeTitle)
                    .padding()

                Text("Здесь какой-то текст с информацией о приложении")
                    .multilineTextAlignment(.center)
                    .padding()

                Spacer()

//                Button("Назад") {
//                    // Переходим на предыдущий экран
//                    presentationMode.wrappedValue.dismiss()
//                }
//                .padding()
            }
            .navigationBarTitle("", displayMode: .inline)
        }
    }
}
