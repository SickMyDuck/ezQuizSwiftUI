//
//  MenuViewModelProtocol.swift
//  ezQuiz
//
//  Created by Ruslan Sadritdinov on 31.03.2023.
//

import Foundation
import SwiftUI

protocol MenuViewModelProtocol: ObservableObject {
    var user: String { get }

    func navigateTo<Destination: View>(destination: Destination)
}
