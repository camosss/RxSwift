//
//  PhotoCollectionViewController.swift
//  CameraFilter
//
//  Created by 강호성 on 2021/12/05.
//

import UIKit
import Photos
import RxSwift

class PhotoCollectionViewController: UICollectionViewController {
    
    // MARK: - Properties
    
    private var images = [PHAsset]()
    private let selectedPhotoSubject = PublishSubject<UIImage>()
    var selectedPhoto: Observable<UIImage> {
        return selectedPhotoSubject.asObservable()
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        populatePhoto()
    }
    
    // MARK: - Helper
    
    private func populatePhoto() {
        PHPhotoLibrary.requestAuthorization { [weak self] status in
            if status == .authorized {
                
                let assets = PHAsset.fetchAssets(with: PHAssetMediaType.image, options: nil)
                assets.enumerateObjects { (object, count, stop) in
                    self?.images.append(object)
                }
                self?.images.reverse() // reverts to the most recent images are at the top
                
                DispatchQueue.main.async {
                    self?.collectionView.reloadData()
                }
                
            }
        }
    }
}

// MARK: - UICollectioinViewDataSource, UiCollectionViewDelegate

extension PhotoCollectionViewController {
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.identifier, for: indexPath) as! PhotoCollectionViewCell
        
        let asset = self.images[indexPath.row]
        let manager = PHImageManager.default() // singleton
        
        manager.requestImage(for: asset, targetSize: CGSize(width: 100, height: 100), contentMode: .aspectFit, options: nil) { image, _ in
            DispatchQueue.main.async {
                cell.photoImageView.image = image
            }
        }
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let selectedAsset = self.images[indexPath.row]
        let manager = PHImageManager.default() // singleton
        
        manager.requestImage(for: selectedAsset, targetSize: CGSize(width: 300, height: 300), contentMode: .aspectFit, options: nil) { [weak self] image, info in
            
            guard let info = info else { return }
            
            let isDegradedImage = info["PHImageResultIsDegradedKey"] as! Bool
            if !isDegradedImage {
                if let image = image {
                    self?.selectedPhotoSubject.onNext(image)
                    self?.dismiss(animated: true, completion: nil)
                }
            }
        }
        
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension PhotoCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 150)
    }
}
