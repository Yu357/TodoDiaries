//
//  FirstView.swift
//  FireTodoDiary
//
//  Created by Yu on 2022/02/11.
//

import SwiftUI

struct FirstView: View {
    
    @ObservedObject var pinnedTodoViewModel = TodoViewModel(isPinned: true)
    @ObservedObject var unpinnedTodoViewModel = TodoViewModel()
    
    @State var isShowCreateSheet = false
    @State var isShowEditSheet = false
    
    var body: some View {
        NavigationView {
            
            List {
                // Pinned Todos Section
                if pinnedTodoViewModel.todos.count != 0 {
                    Section(header: Text("固定済み")) {
                        ForEach(pinnedTodoViewModel.todos){todo in
                            Button(todo.content) {
                                isShowEditSheet.toggle()
                            }
                            .foregroundColor(.primary)
                            .sheet(isPresented: $isShowEditSheet) {
                                EditTodoView(todo: todo)
                            }
                        }
                        .onMove {sourceIndexSet, destination in
                            //TODO: Update order
                        }
                    }
                }
                // Not Pinned Todos Section
                if unpinnedTodoViewModel.todos.count != 0{
                    Section(header: pinnedTodoViewModel.todos.count == 0 ? nil : Text("その他")) {
                        ForEach(unpinnedTodoViewModel.todos){todo in
                            Button(todo.content) {
                                isShowEditSheet.toggle()
                            }
                            .foregroundColor(.primary)
                            .sheet(isPresented: $isShowEditSheet) {
                                EditTodoView(todo: todo)
                            }
                        }
                        .onMove {sourceIndexSet, destination in
                            //TODO: Update order
                        }
                    }
                }
            }
            
            .sheet(isPresented: $isShowCreateSheet) {
                CreateTodoView()
            }
            
            .navigationBarTitle("Todos")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        isShowCreateSheet.toggle()
                    }) {
                        Image(systemName: "plus")
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    CustomEditButton()
                }
            }
        }
    }
}
