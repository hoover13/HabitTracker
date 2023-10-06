//
//  AddView.swift
//  HabitTracker
//
//  Created by Min Thu Khine on 10/4/23.
//
 
import SwiftUI

struct AddSheetView: View {
    
    @State private var task = ""
    @Binding  var tasks: [TaskItem]
    @Binding var sheetVisible: Bool 
   
    
    var body: some View {
        VStack {
            Spacer()
            Section {
                TextField("Enter your tasks and press return.", text: $task)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.blue, lineWidth: 2))
                                    .padding(.horizontal, 30)
                    
            }
            
            Section {
                List {
                    ForEach(tasks) { item in
                        Text(item.name)
                        
                    }
                  
                }
            }
               
            Button(action: {
//                sheetDismiss = true
                
                sheetVisible = false
            }, label: {
                Text("Done")
                    .padding(20)
                    .background(.blue)
                    .foregroundColor(.white)
                    .cornerRadius(50)
            })
        }
        .onSubmit {
            addTask()
        }
    }
    
    func addTask() {
        tasks.append(TaskItem(name: task))
        task = ""
    }
}

//#Preview {
//    
//    AddSheetView(tasks: .constant(Task), sheetVisible: <#T##Binding<Bool>#>)
//}
