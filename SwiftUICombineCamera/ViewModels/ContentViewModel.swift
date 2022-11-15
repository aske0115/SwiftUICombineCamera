//
//  ContentViewModel.swift
//  SwiftUICombineCamera
//
//  Created by 1101249 on 11/15/22.
//

import CoreImage

class ContentViewModel: ObservableObject {
    @Published var frame: CGImage?
    
    private let frameManager = FrameManager.shared
    
    init() {
        setupSubscriptions()
    }
    
    func setupSubscriptions() {
        frameManager.$current
            .receive(on: RunLoop.main)
            .compactMap { pixelBuffer in
                if let buffer = pixelBuffer {
                    let ciContext = CIContext()
                    let ciImage = CIImage(cvImageBuffer: buffer)
                    return ciContext.createCGImage(ciImage, from: ciImage.extent)
                } else {
                    return nil
                }
            }.assign(to: &$frame)
    }
}
