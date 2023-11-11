//
//  CameraToolbarView.swift
//  SnapSplash
//
//  Created by Riccardo Washington on 10/30/23.
//

import SwiftUI

struct CameraToolbarView: View {
    @ObservedObject var viewModel: CameraViewModel
    
    var body: some View {
        HStack {
            ToolButtonView(imageName: "camera.fill")
            Spacer()
            Circle()
                .frame(width: 70, height: 70)
                .overlay(Circle().stroke(Color.white, lineWidth: 5))
                .padding()
            Spacer()
            ToolButtonView(imageName: "photo.on.rectangle.angled")
        }
        .padding()
    }
}
