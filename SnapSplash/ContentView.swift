//
//  ContentView.swift
//  SnapSplash
//
//  Created by Riccardo Washington on 4/26/23.
//

import SwiftUI
import UIKit
import Photos

struct ContentView: View {
    @State private var image: UIImage?
    @State private var isImagePickerShown = false
    @State private var filterIntensity = 0.5
    
    var body: some View {
        VStack {
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            } else {
                Text("Select an image to edit")
            }
            
            Button("Choose Image") {
                isImagePickerShown = true
            }
            
            Slider(value: $filterIntensity, in: 0...1)
            
            Button("Apply Filter") {
                applyFilter()
            }
            
            Button("Save Image") {
                saveImage()
            }
        }
        .sheet(isPresented: $isImagePickerShown) {
            ImagePicker(image: $image, isShown: $isImagePickerShown)
        }
    }
    
    func applyFilter() {
        guard let inputImage = CIImage(image: image!) else { return }
        let filter = CIFilter(name: "CISepiaTone")
        filter?.setValue(inputImage, forKey: kCIInputImageKey)
        filter?.setValue(filterIntensity, forKey: kCIInputIntensityKey)
        
        guard let outputImage = filter?.outputImage else { return }
        let context = CIContext()
        guard let cgImage = context.createCGImage(outputImage, from: outputImage.extent) else { return }
        let uiImage = UIImage(cgImage: cgImage)
        image = uiImage
    }
    
    func saveImage() {
        guard let imageToSave = image else { return }
        PHPhotoLibrary.requestAuthorization { status in
            if status == .authorized {
                PHPhotoLibrary.shared().performChanges({
                    PHAssetChangeRequest.creationRequestForAsset(from: imageToSave)
                }, completionHandler: { success, error in
                    if success {
                        print("Image saved to photo library")
                    } else {
                        print("Error saving image: \(String(describing: error))")
                    }
                })
            } else {
                print("Permission not granted to save image")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
