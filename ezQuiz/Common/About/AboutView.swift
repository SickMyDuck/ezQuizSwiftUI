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

    var body: some View {
        NavigationView {
            VStack {
                Text("Hello there")
                    .font(.largeTitle)
                    .padding()

                Text("My name is Ruslan, and I am the only developer of this app, that's why it may seem a bit buggy. If you found any, please, contact me at telegram. \n \n Also feel free to ask me any questions or share your thoughts.")

                    .padding()

                Link("My tg: @seeq_my_duck", destination: viewModel.myTg)


                    .padding()
                HStack {
                    Text("You can also find source code here")
                        .foregroundColor(.blue)
                        .onTapGesture {
                            UIApplication.shared.open(viewModel.githubLink)
                        }
                        .padding()
                }

                Spacer()
            }
            .navigationBarTitle("", displayMode: .inline)
        }
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}
