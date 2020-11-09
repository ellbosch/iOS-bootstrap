//
//  ProjectListView.swift
//  Lobe_iOS
//
//  Created by Elliot Boschwitz on 10/12/20.
//  Copyright © 2020 Adam Menges. All rights reserved.
//

import SwiftUI
import Vision

struct ProjectListView: View {
    @State private var isProjectPicker = false
    @Binding var selectedModel: VNCoreMLModel?
    
    var body: some View {
        NavigationView {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                .navigationBarTitle(Text("Projects"))
                .navigationBarItems(trailing:
                                        Button(action: {
                                            self.isProjectPicker.toggle()
                                        }, label: {
                                            Text("Import")
                                        })
                                        .sheet(isPresented: $isProjectPicker) {
                                            ProjectPicker(selectedModel: $selectedModel)
                                        }
                )
        }
    }
}
//
//struct ProjectListView_Previews: PreviewProvider {
//    @Binding var selectedModel: VNCoreMLModel?
//    
//    static var previews: some View {
//        ProjectListView(selectedModel: $selectedModel)
//    }
//}
