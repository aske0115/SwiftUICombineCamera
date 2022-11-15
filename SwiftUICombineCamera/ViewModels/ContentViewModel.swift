//
//  ContentViewModel.swift
//  SwiftUICombineCamera
//
//  Created by 1101249 on 11/15/22.
//

import CoreImage

class ContentViewModel: ObservableObject {
    @Published var frame: CGImage?
    @Published var error: Error?
    
    private let context = CIContext()

    var comicFilter = false
    var lineOverlayFilter = false
    var crystalFilter = false
    
    private let cameraManager = CameraManager.shared
    private let frameManager = FrameManager.shared
    
    init() {
        setupSubscriptions()
    }
    
    func setupSubscriptions() {
        frameManager.$current
            .receive(on: RunLoop.main)
            .compactMap { $0 }
            .compactMap { pixelBuffer in
                var ciImage = CIImage(cvImageBuffer: pixelBuffer)
                
                if self.comicFilter {
                    ciImage = ciImage.applyingFilter("CIComicEffect")
                }
                
                if self.crystalFilter {
                    ciImage = ciImage.applyingFilter("CICrystallize")
                }
                
                if self.lineOverlayFilter {
                    ciImage = ciImage.applyingFilter("CILineOverlay")
                }
      
                return self.context.createCGImage(ciImage, from: ciImage.extent)
                
            }.assign(to: &$frame)
        
        cameraManager.$error
            .receive(on: RunLoop.main)
            .map { $0 }
            .assign(to: &$error)
    }
}
