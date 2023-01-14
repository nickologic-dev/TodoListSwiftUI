//
//  TodoRowView.swift
//  TodoListSwiftUI
//
//  Created by Nicole Beilis on 1/14/23.
//

import SwiftUI

struct TodoRowView: View {
    
    let title: String
    let description: String
    let date: Date
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .bold()
            Text(description)
            Text(date, style: .date)
        }
    }
}

struct TodoRowView_Previews: PreviewProvider {
    static var previews: some View {
        TodoRowView(title: "", description: "", date: Date.now)
    }
}
