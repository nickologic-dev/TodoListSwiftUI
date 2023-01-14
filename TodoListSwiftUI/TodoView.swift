//
//  TodoView.swift
//  TodoListSwiftUI
//
//  Created by Nicole Beilis on 1/14/23.
//

import SwiftUI

struct TodoView: View {
    
    @Environment(\.scenePhase) private var scenePhase
    @StateObject var todoList : TodoModel
    let saveAction: () -> Void
    
    var body: some View {
        List {
            Section {
                ForEach(Array(todoList.todos.enumerated()), id: \.element) { index, todo in
                    NavigationLink {
                        TodoDetailView(
                            todo: todo,
                            list: todoList,
                            index: index,
                            createMode: false)
                    } label: {
                        TodoRowView(
                            title: todo.title,
                            description: todo.description,
                            date: todo.date)
                    }
                }
                .onDelete(perform: todoList.removeTodo)
            }
        }
        .navigationTitle("Todo List")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink {
                    TodoDetailView(
                        todo: Todo(
                            id: UUID(),
                            title: "",
                            description: "",
                            date: Date.now),
                        list: todoList,
                        index: 0,
                        createMode: true)
                } label: {
                    Image.init(systemName: "plus.circle")
                }
            }
        }
        .onChange(of: scenePhase) { phase in
            if phase == .inactive { saveAction() }
        }
    }
}

struct TodoView_Previews: PreviewProvider {
    static var previews: some View {
        TodoView(todoList: TodoModel()) {
            
        }
    }
}
