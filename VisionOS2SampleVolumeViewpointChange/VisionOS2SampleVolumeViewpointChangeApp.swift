//
//  VisionOS2SampleVolumeViewpointChangeApp.swift
//  VisionOS2SampleVolumeViewpointChange
//
//  Created by Sadao Tokuyama on 7/12/24.
//

import SwiftUI

@main
struct VisionOS2SampleVolumeViewpointChangeApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .windowStyle(.volumetric)
    }
}
