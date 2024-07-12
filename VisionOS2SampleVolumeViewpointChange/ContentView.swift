//
//  ContentView.swift
//  VisionOS2SampleVolumeViewpointChange
//
//  Created by Sadao Tokuyama on 7/12/24.
//

import SwiftUI
import RealityKit

struct ContentView: View {

    @State var drummerRotation: Rotation3D = .identity
    
    var body: some View {
        VStack {
            Model3D(named: "toy_drummer_idle") {phase in
                 if let model = phase.model {
                     model
                         .resizable()
                         .aspectRatio(contentMode: .fit)
                 } else if phase.error != nil {
                     VStack {
                         Image(systemName: "x.circle.fill")
                             .font(.extraLargeTitle2)
                         Text("Failed to load model.")
                     }
                 } else {
                     ProgressView()
                }
            }
            RealityView { content in
                if let drummerEntity = try? await Entity(named: "toy_drummer_idle") {
                    drummerEntity.scale*=3.5
                    drummerEntity.position.x+=0.025
                    drummerEntity.position.y-=0.2
                    drummerEntity.position.z-=0.3
                    let count = drummerEntity.availableAnimations.count
                        if count > 0 {
                            drummerEntity.playAnimation(drummerEntity.availableAnimations[count - 1].repeat())
                    }
                    content.add(drummerEntity)
                }
            }
        }.onVolumeViewpointChange{ _, newValue in
            drummerRotation = Rotation3D.slerp(
                from: drummerRotation,
                to: newValue.squareAzimuth.orientation,
                t: 1.0,
                along: .shortest
            )
        }
        .rotation3DEffect(drummerRotation)
        .animation(.easeInOut, value: drummerRotation)
    }
}

#Preview(windowStyle: .volumetric) {
    ContentView()
}
