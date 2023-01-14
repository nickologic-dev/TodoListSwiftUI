//
//  TodoModel.swift
//  TodoListSwiftUI
//
//  Created by Nicole Beilis on 1/14/23.
//

import Foundation

public class TodoModel: ObservableObject, Identifiable {
    
    @Published var todos : [Todo] = []
    
    // implement persistent store
    
    private static func fileURL() throws -> URL {
        try FileManager.default.url(for: .documentDirectory,
                                       in: .userDomainMask,
                                       appropriateFor: nil,
                                       create: false)
            .appendingPathComponent("todos.data")
    }
    
    static func load(completion: @escaping (Result<[Todo], Error>)->Void) {
        DispatchQueue.global(qos: .background).async {
            do {
                let fileURL = try fileURL()
                guard let file = try? FileHandle(forReadingFrom: fileURL) else {
                    DispatchQueue.main.async {
                        completion(.success([]))
                    }
                    return
                }
                let todos = try JSONDecoder().decode([Todo].self, from: file.availableData)
                DispatchQueue.main.async {
                    completion(.success(todos))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
    
    static func save(todos: [Todo], completion: @escaping (Result<Int, Error>)->Void) {
        DispatchQueue.global(qos: .background).async {
            do {
                let data = try JSONEncoder().encode(todos)
                let outfile = try fileURL()
                try data.write(to: outfile)
                DispatchQueue.main.async {
                    completion(.success(todos.count))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }

    // helper functions 
    
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

struct Todo: Identifiable, Equatable, Hashable, Codable {
    
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
