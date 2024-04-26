//
//  PhotoManager.swift
//  photoAlbum
//
//  Created by 조호근 on 4/26/24.
//

import UIKit
import Photos

class PhotoManager: NSObject {
    enum NotificationNames {
        static let didChangePhotos = Notification.Name("didChangePhotos")
    }
    private var allPhotos: PHFetchResult<PHAsset>!
    private var imageManager: PHCachingImageManager!
    
    var count: Int {
        return self.allPhotos.count
    }
    
    override init() {
        super.init()
        self.fetchPhotos()
        
        switch PHPhotoLibrary.authorizationStatus() {
        case .authorized:
            PHPhotoLibrary.shared().register(self)
        default:
            return
        }
    }
    
    private func fetchPhotos() {
        let allPhotosOptions = PHFetchOptions()
        allPhotosOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: true)]
        allPhotos = PHAsset.fetchAssets(with: allPhotosOptions)
        imageManager = PHCachingImageManager()
    }
    
    func makePhotoData(index: Int, size: CGSize, completion: @escaping (UIImage?) -> Void) {
        let asset = self.allPhotos.object(at: index)
        imageManager.requestImage(for: asset,
                                  targetSize: size,
                                  contentMode: .aspectFill,
                                  options: nil) { image, _ in
            completion(image)
        }
    }
}

extension PhotoManager: PHPhotoLibraryChangeObserver {
    func photoLibraryDidChange(_ changeInstance: PHChange) {
        DispatchQueue.main.async {
            if let changes = changeInstance.changeDetails(for: self.allPhotos) {
                self.allPhotos = changes.fetchResultAfterChanges
    
                NotificationCenter.default.post(name: NotificationNames.didChangePhotos, object: nil)
            }
        }
    }
}
