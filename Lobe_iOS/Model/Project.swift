//
//  Project.swift
//  Lobe_iOS
//
//  Created by Elliot Boschwitz on 10/11/20.
//  Copyright © 2020 Adam Menges. All rights reserved.
//

import Foundation

public struct Project: Codable {
    var id: String
    var meta: ProjectMeta
}

public struct ProjectMeta: Codable {
    var name: String
}
