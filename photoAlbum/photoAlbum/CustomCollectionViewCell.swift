//
//  CustomCollectionViewCell.swift
//  photoAlbum
//
//  Created by 조호근 on 4/22/24.
//

import UIKit
import PhotosUI

class CustomCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var livePhotoBadge: UIImageView!
    
    func configure(with photoInfo: PhotoInfo) {
        imageView.image = photoInfo.image
        livePhotoBadge.isHidden = !photoInfo.isLivePhoto
        if photoInfo.isLivePhoto {
            livePhotoBadge.image = PHLivePhotoView.livePhotoBadgeImage(options: .overContent)
        }
    }
}
