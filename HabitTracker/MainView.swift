//
//  ContentView.swift
//  HabitTracker
//
//  Created by Min Thu Khine on 10/4/23.
//this is chris testing pull requests
// I updated some changes.

import SwiftUI

struct TaskItem: Identifiable {
    let id = UUID()
    var name: String
    var isCompleted: Bool = false
}

struct MainView: View {
    
    @State private var addSheetVisible = false
    @State private var recommendationSheetVisible = false
    @State private var tasks = [TaskItem]()
    @State private var isCompleteTaskAlert = false
    @State private var isAllTasksCompleted = false
    
    var completedTasks: Int {
        tasks.filter{$0.isCompleted}.count
    }
    
    var totalTasks: Int {
        tasks.count
    }
    
    var percentComplete : CGFloat {
        
        if tasks.isEmpty{
            return 0
        } else {
            return Double(completedTasks) / Double(totalTasks)
        }
    }
    
    
    var body: some View {
        
        //        NavigationStack {
        VStack {
            Text("Habit Tracker")
                .font(.largeTitle)
                .bold()
                .underline()
            Divider()
            
            Text("You have completed \(completedTasks) out of \(totalTasks) tasks")
                .bold()
            
            ZStack(alignment: .leading) {
                
                ZStack {
                    Capsule().fill(Color.black.opacity(0.08)).frame(height: 25)
                }
                Capsule()
                    .fill(LinearGradient(gradient: Gradient(colors: [Color.mint, Color.blue]), startPoint: .leading, endPoint: .trailing))
                    .frame(width: isAllTasksCompleted ? 0 : 360 * percentComplete  , height: 25)
                
            }
            .padding()
            
            
            List {
                
                //Consider delete function
                
                ForEach(tasks) { item in
                    HStack {
                        Text(item.name)
                        Spacer()
                        Button(action: {
                            print(completedTasks)
                            print("___")
                            print(totalTasks)
                            toggleCompletion(for: item)
                            if completedTasks  == totalTasks {
                                isCompleteTaskAlert = true
                                //                                    tasks = []
                            }
                            
                            
                        }, label: {
                            Image(systemName: item.isCompleted ? "checkmark.circle.fill" : "circle")
                        })
                        
                    }
                }
              
             
                .onMove(perform: move)
                .onDelete(perform: deleteTask)
               
             
                
            }
           
            .environment(\.defaultMinListRowHeight, 60)
            
             // Hide default separators
          
            
            
            Spacer()
            
            HStack {
                Button(action: {
                    addSheetVisible = true
                }, label: {
                    Text("Add")
                        .frame(width: 150, height: 50)
                        .background(.cyan)
                        .foregroundColor(.white)
                        .cornerRadius(20)
                    
                })
                
                Button(action: {
                    recommendationSheetVisible = true
                }, label: {
                    Text("Recommend")
                        .frame(width: 150, height: 50)
                        .background(.green)
                        .foregroundColor(.white)
                        .cornerRadius(20)
                    
                })
            }
        }
        //            .navigationBarItems(leading: EditButton())
        //        }
        
        
        .sheet(isPresented: $addSheetVisible, content: {
            AddSheetView(tasks: $tasks, sheetVisible: $addSheetVisible)
        })
        .sheet(isPresented: $recommendationSheetVisible, content: {
            RecommendationSheetView(recommendedTasks: $tasks, sheetVisible: $recommendationSheetVisible)
        })
        
        .alert(isPresented: $isCompleteTaskAlert) {
            
            Alert(
                title: Text("Congratulations!🎉🎊"),
                message: Text("You have finished all tasks for today."),
                dismissButton: .default(Text("OK")) {
                    isAllTasksCompleted = true
                    for index in 0..<tasks.count {
                        tasks[index].isCompleted = false
                    }
                }
            )
            
        }
        
    }
    
    func toggleCompletion(for task: TaskItem) {
        isAllTasksCompleted = false
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks[index].isCompleted.toggle()
        }
        
    }
    
    func deleteTask(at offsets: IndexSet) {
        tasks.remove(atOffsets: offsets)
    }
    
    func move(from source: IndexSet, to destination: Int) {
        tasks.move(fromOffsets: source, toOffset: destination)
    }
    
    func test() {
        
    }
    
}

#Preview {
    MainView()
}
