//
//  ProjectPickerViewController.swift
//  Lobe_iOS
//
//  Created by Elliot Boschwitz on 11/1/20.
//  Copyright © 2020 Adam Menges. All rights reserved.
//

import SwiftUI
import UIKit

// MARK: - View controller for document picker
class ProjectPickerViewController: UIDocumentPickerViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

// MARK: - Coordinator class for documenter picker.
struct ProjectPicker: UIViewControllerRepresentable {

    func makeUIViewController(context: Context) -> UIDocumentPickerViewController {
        let projectPicker = ProjectPickerViewController(documentTypes: ["mlmodel"], in: .import)
        projectPicker.delegate = context.coordinator
        return projectPicker
    }
    
    func updateUIViewController(_ uiViewController: UIDocumentPickerViewController, context: Context) {}

    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UIDocumentPickerDelegate, UINavigationControllerDelegate {
        var parent: ProjectPicker
        
        init(_ parent: ProjectPicker) {
            self.parent = parent
        }

        // MARK: - Updates model after file selected.
        func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
            print("Doc URLS: \(urls)")
        }
    }
    
}
