//
//  FilterService.swift
//  CameraFilter
//
//  Created by 강호성 on 2021/12/05.
//

import UIKit
import CoreImage
import RxSwift

class FilterService {
    private var context: CIContext
    
    init() {
        self.context = CIContext()
    }
    
    // MARK: - Helper
    
    func applyFilter(to inputImage: UIImage) -> Observable<UIImage> {
        return Observable<UIImage>.create { observer in
            self.applyFilter(to: inputImage) { filterdImage in
                observer.onNext(filterdImage)
            }
            return Disposables.create()
        }
    }
    
    // 필터링된 파일에 대한 액세스를 제공
    private func applyFilter(to inputImage: UIImage, completion: @escaping ((UIImage) -> ())) {
        
        // create Filter
        let filter = CIFilter(name: "CICMYKHalftone")!
        filter.setValue(2.0, forKey: kCIInputWidthKey) // 필터에 값 설정
        
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
