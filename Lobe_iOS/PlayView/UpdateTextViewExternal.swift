//
//  UpdateTextViewExternal.swift
//  Lobe_iOS
//
//  Created by Kathy Zhou on 6/4/20.
//  Copyright © 2020 Microsoft. All rights reserved.
//

import Foundation
import SwiftUI

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
    var projectName: String?
    
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .center) {
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
                    
                        VStack(alignment: .leading) {
                            Text(self.viewModel.classificationLabel ?? "Loading...")
                                .font(.system(size: 28))
                            Text(self.projectName ?? "Project Not Loaded")
                                .font(.system(size: 12))
                                .fontWeight(.bold)
                        }
                        .foregroundColor(.white)
                        .padding()
                    }
                }
                .frame(width: geometry.size.width / 1.2,
                       height: 75,
                       alignment: .center
                )
                .cornerRadius(17.0)
                .padding()
            }
            .frame(width: geometry.size.width)
        }
    }
}

struct UpdateTextViewExternal_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { geometry in
            ZStack(alignment: .center) {
                Image("testing_image")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .edgesIgnoringSafeArea(.all)
                    .frame(width: geometry.size.width,
                           height: geometry.size.height)
                UpdateTextViewExternal(viewModel: MyViewController(), projectName: "Project Name").zIndex(0)
            }.frame(width: geometry.size.width,
                    height: geometry.size.height)
        }
    }
}
