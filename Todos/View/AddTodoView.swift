//
//  AddTodoView.swift
//  Todos
//
//  Created by wizz on 12/8/21.
//

import SwiftUI

struct AddTodoView: View {
    //MARK: - PROPERTIES
    @State private var name = ""
    @State private var priority = "Normal"
    @State private var errorShowing = false
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.presentationMode) var presentationMode
    
    let priorities = ["high","Normal", "Low"]
    
    
    //MARK: - BODY
    var body: some View {
        NavigationView{
            VStack {
                Form{
                    TextField("Todo", text: $name)
                    Picker("Priority", selection: $priority){
                        ForEach(priorities, id:\.self){
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                    
                    //MARK: - SAVE BUTTON
                    Button {
                        if name != "" {
                            let todo = Todos(context: managedObjectContext)
                            todo.name = name
                            todo.priority = priority
                            
                            do{
                                try managedObjectContext.save()
                                print("New todo: \(todo.name ?? "")")
                            }catch{
                                print(error.localizedDescription)
                            }
                        }else{
                            errorShowing = true
                            errorTitle = "Invalid name"
                            errorMessage = "Please ensure you enter value"
                            
                            return
                        }
                        presentationMode.wrappedValue.dismiss()
                        
                    } label: {
                        Text("Save")
                    }

                }
                Spacer()
            }
            .navigationTitle("New Todo")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            presentationMode.wrappedValue.dismiss()
                        } label: {
                            Image(systemName: "xmark")
                        }

                    }
                }
            .alert(isPresented: $errorShowing) {
                Alert(title: Text(errorTitle), message: Text(errorMessage), dismissButton: .default(Text("Ok")))
            }
        }
    }
}

//MARK: - PREVIEW
struct AddTodoView_Previews: PreviewProvider {
    static var previews: some View {
        AddTodoView()
    }
}
