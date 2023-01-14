//
//  ContentView.swift
//  TodoListSwiftUI
//
//  Created by Nicole Beilis on 1/14/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            TodoView(todoList: TodoModel())
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
