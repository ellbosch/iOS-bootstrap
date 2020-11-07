//
//  ProjectListView.swift
//  Lobe_iOS
//
//  Created by Elliot Boschwitz on 10/12/20.
//  Copyright © 2020 Adam Menges. All rights reserved.
//

import SwiftUI

struct ProjectListView: View {
    @State private var isProjectPicker = false
    
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
                                            ProjectPicker()
                                        }
                )
        }
    }
}

struct ProjectListView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectListView()
    }
}
