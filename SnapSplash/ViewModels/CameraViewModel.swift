//
//  CameraViewModel.swift
//  SnapSplash
//
//  Created by Riccardo Washington on 10/30/23.
//


import SwiftUI
import AVFoundation

class CameraViewModel: ObservableObject {
    @Published var selectedTool: Int = 0
    
    private(set) var captureSession: AVCaptureSession?
    
    init() {
        self.captureSession = AVCaptureSession()
    }
       
       func startSession() {
           guard let captureSession = captureSession else {
               self.captureSession = AVCaptureSession()
               return
           }
           
           guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return }
           let videoInput: AVCaptureDeviceInput
           
           do {
               videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
           } catch {
               return
           }
           
           if (captureSession.canAddInput(videoInput)) {
               captureSession.addInput(videoInput)
           } else {
               return
           }
           
           let videoOutput = AVCaptureVideoDataOutput()
           if (captureSession.canAddOutput(videoOutput)) {
               captureSession.addOutput(videoOutput)
           } else {
               return
           }
           DispatchQueue.global(qos: .userInteractive).async {
               
               captureSession.startRunning()
           }
       }
       
    func stopSession() {
        captureSession?.stopRunning()
    }
}
