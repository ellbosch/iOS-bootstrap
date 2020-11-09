//
//  UpdateTextViewExternal.swift
//  Lobe_iOS
//
//  Created by Kathy Zhou on 6/4/20.
//  Copyright © 2020 Adam Menges. All rights reserved.
//

import Foundation
import SwiftUI
import Vision

struct VisualEffectView: UIViewRepresentable {
    var effect: UIVisualEffect?
    func makeUIView(context: UIViewRepresentableContext<Self>) -> UIVisualEffectView { UIVisualEffectView() }
    func updateUIView(_ uiView: UIVisualEffectView, context: UIViewRepresentableContext<Self>) { uiView.effect = effect }
}

/* View for displaying the green bar containing the prediction label. */
struct UpdateTextViewExternal: View {
    @ObservedObject var viewModel: MyViewController
    @State private var showImagePicker: Bool = false
    @State private var image: UIImage?
    @State private var showProjectListView = false
    @Binding var model: VNCoreMLModel?
    
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .center) {
                HStack(alignment: .center) {
                    Button(action: {
                        self.showProjectListView.toggle()
                    }) {
                        ZStack (alignment: .leading) {
                            Rectangle()
                                .foregroundColor(Color(.gray))
                                .opacity(0.5)
                            
                            Text(self.viewModel.projectName ?? "No project loaded.")
                                .padding()
                                .foregroundColor(.white)
                                .font(.system(size: 28))
                        }
                    }.sheet(isPresented: $showProjectListView) {
                        ProjectListView(selectedModel: $model)
                    }
                }
                .frame(width: geometry.size.width / 1.2,
                       height: 65,
                       alignment: .center
                )
                .cornerRadius(17.0)
                .padding()
                Spacer()
                HStack(alignment: .center) {
                    ZStack (alignment: .leading) {
                        Rectangle()
                            .foregroundColor(Color(UIColor(rgb: 0x33987A)))
                            .opacity(0.88)
                        
                        Rectangle()
                            .foregroundColor(Color(UIColor(rgb: 0x00DDAD)))
                            .frame(width: min(CGFloat(self.viewModel.confidence ?? 0) * geometry.size.width / 1.2, geometry.size.width / 1.2))
                            .animation(.linear)
                    
                        Text(self.viewModel.classificationLabel ?? "Loading...")
                            .padding()
                            .foregroundColor(.white)
                            .font(.system(size: 28))
                    }
                }
                .frame(width: geometry.size.width / 1.2,
                       height: 65,
                       alignment: .center
                )
                .cornerRadius(17.0)
                .padding()
            }
            .frame(width: geometry.size.width)
        }
    }
}

// TO-DO: fix previews to work with model binding
//struct UpdateTextViewExternal_Previews: PreviewProvider {
//    static var previews: some View {
//        GeometryReader { geometry in
//            ZStack(alignment: .center) {
//                Image("testing_image")
//                    .resizable()
//                    .aspectRatio(contentMode: .fill)
//                    .edgesIgnoringSafeArea(.all)
//                    .frame(width: geometry.size.width,
//                           height: geometry.size.height)
//                UpdateTextViewExternal(viewModel: MyViewController()).zIndex(0)
//            }.frame(width: geometry.size.width,
//                    height: geometry.size.height)
//        }
//    }
//}
