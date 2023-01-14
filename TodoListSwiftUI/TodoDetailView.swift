//
//  TodoDetailView.swift
//  TodoListSwiftUI
//
//  Created by Nicole Beilis on 1/14/23.
//

import SwiftUI

struct TodoDetailView: View {
    
    @Environment(\.dismiss) private var dismiss
    @State var todo: Todo
    @State var list: TodoModel
    let index: Int
    let createMode: Bool
    
    var body: some View {
        Form {
            Section("Title") {
                TextField(
                    "Title",
                    text: $todo.title
                )
            }

            Section("Description") {
                TextEditor(text: $todo.description)
            }

            Section{
                DatePicker(selection: $todo.date, displayedComponents: .date) {
                    Text("Date")
                }
            }
        }
        .navigationBarTitle("Task Detail")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    if createMode {
                        list.addTodo(todo: todo)
                    } else {
                        list.updateTodo(todo: todo, index: index)
                    }
                    dismiss()
                } label: {
                    Text("Save")
                }
                .disabled(disable())
            }
        }
    }
    
    private func disable() -> Bool {
        todo.title == "" || todo.description == ""
    }
}

struct TodoDetailView_Previews: PreviewProvider {
    static var previews: some View {
        TodoDetailView(
            todo: Todo(
                id: UUID(),
                title: "",
                description: "",
                date: Date.now),
            list: TodoModel(),
            index: 0,
            createMode: true)
    }
}
