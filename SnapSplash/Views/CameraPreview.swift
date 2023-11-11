//
//  CameraPreview.swift
//  SnapSplash
//
//  Created by Riccardo Washington on 10/30/23.
//

import SwiftUI
import AVFoundation

import SwiftUI
import AVFoundation

//struct CameraPreview: UIViewRepresentable {
//    class Coordinator {
//        var cameraSession: AVCaptureSession
//        
//        init(cameraSession: AVCaptureSession) {
//            self.cameraSession = cameraSession
//        }
//    }
//    
//    var cameraSession: AVCaptureSession?
//    
//    func makeCoordinator() -> Coordinator {
//        if let cameraSession = cameraSession {
//            return Coordinator(cameraSession: cameraSession)
//        } else {
//            return Coordinator(cameraSession: AVCaptureSession())
//        }
//    }
//    
//    func makeUIView(context: Context) -> UIView {
//        let view = UIView(frame: UIScreen.main.bounds)
//        if let cameraSession = cameraSession {
//            let previewLayer = AVCaptureVideoPreviewLayer(session: cameraSession)
//            previewLayer.videoGravity = .resizeAspectFill
//            previewLayer.frame = view.frame
//            
//            view.layer.addSublayer(previewLayer)
//        }
//        return view
//    }
//    
//    func updateUIView(_ uiView: UIView, context: Context) {
//        // Check if the AVCaptureVideoPreviewLayer is already added
//            if let previewLayer = uiView.layer.sublayers?.first as? AVCaptureVideoPreviewLayer {
//                // Update the frame of the previewLayer in case of orientation or layout changes
//                previewLayer.frame = uiView.bounds
//                
//                // Here you can add more code to update other properties of the previewLayer
//                // or the containing UIView based on dynamic data or state in your SwiftUI view
//            }
//    }
//}

import SwiftUI
import AVFoundation

struct CameraPreview: UIViewRepresentable {
    // Create the AVCaptureSession
    let session = AVCaptureSession()

    func makeUIView(context: Context) -> UIView {
        let view = UIView(frame: UIScreen.main.bounds)
        
        // Check if the device has a camera
        guard let device = AVCaptureDevice.default(for: .video) else { return view }
        let input = try? AVCaptureDeviceInput(device: device)
        
        if let input = input, session.canAddInput(input) {
            session.addInput(input)
        }

        // Setup the AVCaptureVideoPreviewLayer
        let previewLayer = AVCaptureVideoPreviewLayer(session: session)
        previewLayer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(previewLayer)
        previewLayer.frame = view.bounds
        
        // Start the session
        DispatchQueue.global(qos: .userInitiated).async {
            session.startRunning()
        }
       

        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, AVCaptureVideoDataOutputSampleBufferDelegate {
        var parent: CameraPreview

        init(_ parent: CameraPreview) {
            self.parent = parent
        }
    }
}

struct CameraPreview_Previews: PreviewProvider {
    static var previews: some View {
        CameraPreview()
    }
}
