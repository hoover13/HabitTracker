//
//  RecommendationSheet.swift
//  HabitTracker
//
//  Created by Min Thu Khine on 10/4/23.
//

import SwiftUI

struct RecommendationSheetView: View {
    
    var recommendations = ["Do Homework", "Go to bed before 11", "Drink water", "Meditate", "Eat vegetables", "No Smoking Vape", "Walk for 30 minutes", "Read a book"]
    @Binding  var recommendedTasks: [TaskItem]
    @Binding var sheetVisible: Bool
//    @State var recommendation = ""
    
    var body: some View {
       
        Form {
            ForEach(recommendations, id: \.self) { item in
                    Button(action: {
//                        recommendation = item
                        addTask(taskName: item)
                        sheetVisible = false
                    }, label: {
                        Text("\(item)")
                            .foregroundStyle(.blue)
                            .padding()
                    })
            }
            
          
        }

    }
    
    func addTask(taskName: String) {
        recommendedTasks.append(TaskItem(name: taskName))
//        recommendation = ""
    }
}

//#Preview {
//    RecommendationSheetView()
//}
