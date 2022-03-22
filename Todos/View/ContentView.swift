//
//  ContentView.swift
//  Todos
//
//  Created by wizz on 12/8/21.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(entity: Todos.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Todos.name, ascending: true)]) var todos: FetchRequest<Todos>
    
    @State private var showingAddToView = false
    var body: some View {
        NavigationView{
            List(0..<5) { item in
                Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            }
            .navigationTitle("Todo")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            showingAddToView.toggle()
                        } label: {
                            Image(systemName: "plus")
                        }
                        .sheet(isPresented: $showingAddToView) {
                            AddTodoView()
                                .environment(\.managedObjectContext, managedObjectContext)
                        }

                    }
                }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
