//
//  CameraView.swift
//  SnapSplash
//
//  Created by Riccardo Washington on 10/30/23.
//

import SwiftUI
import UIKit

struct CameraView: View {
    @ObservedObject var viewModel = CameraViewModel()
    @State private var image: UIImage?
    @State private var isImagePickerShown = false
    
    var body: some View {
        ZStack {
            // Background color
            Color.black.edgesIgnoringSafeArea(.all)
            
            VStack {
                cameraView
//                    .frame(width: UIScreen.main.bounds.width *  0.85,
//                           height: UIScreen.main.bounds.height * 0.75)
//                
                // Bottom bar UI controls
                
                Spacer()
                HStack {
                    Image(systemName: "plus.rectangle")
                    Spacer()
                    Image(systemName: "rectangle.grid.1x2")
                    Spacer()
                    Image(systemName: "clock.arrow.circlepath")
                    Spacer()
                    Image(systemName: "bolt")
                    Spacer()
                    Image(systemName: "camera")
                }
                .foregroundColor(.white)
                .padding()
                
                
                Spacer()
                CameraToolbarView(viewModel: viewModel)
                
            }
        }
              
       
        .sheet(isPresented: $isImagePickerShown) {
            ImagePicker(image: $image, isShown: $isImagePickerShown)
        }
    }
    
    var cameraView: some View {
//        if let image = image {
//            Image(uiImage: image)
//                .resizable()
//                .scaledToFit()
//        } else {
//            Text("Select an image to edit")
//        }
        CameraPreview()
            
            .onAppear {
               // viewModel.startSession()
            }
            .onDisappear {
              //  viewModel.stopSession()
            }
    }
}
