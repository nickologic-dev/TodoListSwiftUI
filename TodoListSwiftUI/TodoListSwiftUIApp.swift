//
//  TodoListSwiftUIApp.swift
//  TodoListSwiftUI
//
//  Created by Nicole Beilis on 1/14/23.
//

import SwiftUI

@main
struct TodoListSwiftUIApp: App {
    
    @StateObject private var store = TodoModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                TodoView(todoList: store) {
                    TodoModel.save(todos: store.todos) { result in
                        if case .failure(let error) = result {
                            fatalError(error.localizedDescription)
                        }
                    }
                }
            }
            .onAppear {
                TodoModel.load { result in
                    switch result {
                    case .failure(let error):
                        fatalError(error.localizedDescription)
                    case .success(let todos):
                        store.todos = todos
                    }
                }
            }
        }
    }
}
