//
//  TodoModel.swift
//  TodoListSwiftUI
//
//  Created by Nicole Beilis on 1/14/23.
//

import Foundation

public class TodoModel: ObservableObject, Identifiable {
    
    @Published var todos : [Todo] = []

    func addTodo(todo: Todo, index: Int? = nil) {
        todos.insert(
            Todo(
                id: UUID(),
                title: todo.title,
                description: todo.description,
                date: todo.date),
            at: index ?? 0)
    }

    func removeTodo(at index: IndexSet) {
        todos.remove(atOffsets: index)
    }

    func updateTodo(todo: Todo, index: Int) {
        removeTodo(at: IndexSet(integer: index))
        addTodo(todo: todo, index: index)
    }
}

struct Todo: Identifiable, Equatable, Hashable {
    
    var id: UUID
    var title: String
    var description: String
    var date: Date
    
    public init(id: UUID, title: String, description: String, date: Date) {
        self.id = id
        self.title = title
        self.description = description
        self.date = date
    }
    
}
