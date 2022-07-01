//
//  ContextMenuGroup.swift
//  FireTodoDiary
//
//  Created by Yu on 2022/02/14.
//

import SwiftUI

struct TodoContextMenuItems: View {
    
    let todo: Todo
    @Binding var isConfirming: Bool
    
    var body: some View {
        Group {
            
            if !todo.isPinned && !todo.isAchieved {
                Button(action: {
                    FireTodo.pinTodo(id: todo.id)
                }) {
                    Label("pin", systemImage: "pin")
                }
            }
            
            if todo.isPinned && !todo.isAchieved {
                Button(action: {
                    FireTodo.unpinTodo(id: todo.id)
                }) {
                    Label("unpin", systemImage: "pin.slash")
                }
            }
            
            if !todo.isAchieved {
                Button(action: {
                    FireTodo.achieveTodo(id: todo.id)
                }) {
                    Label("makeAchieved", systemImage: "checkmark")
                }
            }
            
            if todo.isAchieved {
                Button(action: {
                    FireTodo.unachieveTodo(id: todo.id, achievedAt: todo.achievedAt!)
                }) {
                    Label("makeUnachieved", systemImage: "xmark")
                }
            }
            
            Button(role: .destructive) {
                isConfirming.toggle()
            } label: {
                Label("delete", systemImage: "trash")
            }
        }
    }
}