//
//  CameraManager.swift
//  SwiftUICombineCamera
//
//  Created by 1101249 on 11/15/22.
//

import Foundation
import AVFoundation

class CameraManager: ObservableObject {
    
    @Published var error: CameraError?
    let session = AVCaptureSession()
    private let sessionQueue = DispatchQueue(label: "com.swuiftuiExam.sessionQ")
    private let videoOutput = AVCaptureVideoDataOutput()
    private var status = Status.unconfigured
    
    enum Status {
        case unconfigured
        case configured
        case unauthorized
        case failed
    }
    
    enum CameraError: Error {
        case deniedAuthrization
        case restrictedAuthroization
        case unknownAuthroization
        case cameraUnavaiable
        case cannotAddInput
        case cannotAddOutput
        case createCaptureInput(Error)
    }
    
    static let shared = CameraManager()
    
    private init() {
        configure()
    }
    
    private func configure() {
        checkPermissions()
        sessionQueue.async {
            self.configureCaptureSession()
            self.session.startRunning()
        }
    }
    
    private func set(error: CameraError?) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.error = error
        }
    }
    
    private func checkPermissions() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .notDetermined:
            sessionQueue.suspend()
            AVCaptureDevice.requestAccess(for: .video) { authrized in
                if !authrized {
                    self.status = .unauthorized
                    self.set(error: .deniedAuthrization)
                }
                self.sessionQueue.resume()
            }
        case .restricted:
            status = .unauthorized
            set(error: .restrictedAuthroization)
        case .denied:
            status = .unauthorized
            set(error: .deniedAuthrization)
        case .authorized:
            break
        @unknown default:
            status = .unauthorized
            set(error: .unknownAuthroization)
        }
    }
    
    private func configureCaptureSession() {
        guard status == .unconfigured else {
            return
        }
        
        session.beginConfiguration()
        
        defer {
            session.commitConfiguration()
        }
        
        let device  = AVCaptureDevice.default(.builtInTrueDepthCamera
                                              , for: .video
                                              , position: .front)
        guard let camera = device else {
            set(error: .cameraUnavaiable)
            status = .failed
            return
        }
        
        do {
            let cameraInput = try AVCaptureDeviceInput(device: camera)
            if session.canAddInput(cameraInput) {
                session.addInput(cameraInput)
            } else {
                set(error: .cannotAddInput)
                status = .failed
                return
            }
        } catch {
            set(error: .createCaptureInput(error))
            status = .failed
            return
        }
        
        if session.canAddOutput(videoOutput) {
            session.addOutput(videoOutput)
            
            videoOutput.videoSettings =
            [kCVPixelBufferPixelFormatTypeKey as String: kCVPixelFormatType_32BGRA]
            
            let videoConnection = videoOutput.connection(with: .video)
            videoConnection?.videoOrientation = .portrait
        } else {
            set(error: .cannotAddOutput)
            status = .failed
        }
        status = .configured
    }
    
    func set(_ delegate: AVCaptureVideoDataOutputSampleBufferDelegate, queue: DispatchQueue) {
        sessionQueue.async {
            self.videoOutput.setSampleBufferDelegate(delegate, queue: queue)
        }
    }
}
