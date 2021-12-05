//
//  FilterService.swift
//  CameraFilter
//
//  Created by 강호성 on 2021/12/05.
//

import UIKit
import CoreImage

class FilterService {
    private var context: CIContext
    
    init() {
        self.context = CIContext()
    }
    
    // MARK: - Helper
    
    // 필터링된 파일에 대한 액세스를 제공
    func applyFilter(to inputImage: UIImage, completion: @escaping ((UIImage) -> ())) {
        
        // create Filter
        let filter = CIFilter(name: "CICMYKHalftone")!
        filter.setValue(5.0, forKey: kCIInputWidthKey) // 필터에 값 설정
        
        if let sourceImage = CIImage(image: inputImage) {
            filter.setValue(sourceImage, forKey: kCIInputImageKey)
            
            if let cgImg = self.context.createCGImage(filter.outputImage!, from: filter.outputImage!.extent) {
                
                // 처리할 이미지
                let processedImage = UIImage(cgImage: cgImg, scale: inputImage.scale, orientation: inputImage.imageOrientation)
                completion(processedImage)
            }
        }
        
    }
}
