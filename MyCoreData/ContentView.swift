//
//  ContentView.swift
//  MyCoreData
//
//  Created by 北沢　亮和 on 2022/07/31.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) var viewContext
    
    @State var name = ""
    
    @FetchRequest(sortDescriptors: [])
    var humans: FetchedResults<Human>
    
    var body: some View {
        List {
            ForEach(humans) { human in
                if((human.name?.isEmpty) == false) {
                    HStack {
                        if(human.checked) {
                            Text("☑︎")
                        } else {
                            Text("□")
                        }
                        Button(action: {
                        human.checked.toggle()
                    })
                    {
                        Text(human.name!)
                    }
                    }
                    
                }
                
            }
            
            TextField("人間の名前", text: $name, onCommit: addHuman)
            
            Button(action: DeleteHuman) {
                Text("人間を減らす")
            }
        }
    }
    
    func addHuman() {
        let newHuman = Human(context: viewContext)
        newHuman.name = name
        
        do {
            try viewContext.save()
        } catch {
            fatalError("セーブに失敗しました")
        }
        
        name = ""
    }
    
    func DeleteHuman() {
        for human in humans {
            if(human.checked) {
                viewContext.delete(human)
            }
        }
        
        do {
            try viewContext.save()
        } catch
        {
            fatalError("セーブに失敗")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
