//
//  MVI.swift
//  K-Spam
//
//  Created by Inho Choi on 5/27/25.
//

import SwiftUI

protocol MVIView: View {
    associatedtype State
    var state: State { get }
    
    func bind<T>(_ key: KeyPath<State, T>, _ setter: @escaping (T) -> Void) -> Binding<T>
}

extension MVIView {
    func bind<T>(_ key: KeyPath<State, T>, _ setter: @escaping (T) -> Void) -> Binding<T> {
        Binding(get: { state[keyPath: key] }, set: setter)
    }
}
