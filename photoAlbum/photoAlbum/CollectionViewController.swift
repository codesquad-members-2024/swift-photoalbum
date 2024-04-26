//
//  CollectionViewController.swift
//  photoAlbum
//
//  Created by 조호근 on 4/22/24.
//

import UIKit
import Photos

class CollectionViewController: UIViewController {

    var photoManager: PhotoManager!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        photoManager = PhotoManager()
        registerNotification()
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    private func registerNotification() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(photoLibraryDidChange),
                                               name: PhotoManager.NotificationNames.didChangePhotos,
                                               object: nil)
    }
    
    @objc func photoLibraryDidChange(notification: Notification) {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }

    @IBAction func addBtnTapped(_ sender: Any) {
        let doodleViewController = DoodleViewController()
        let navigationController = UINavigationController(rootViewController: doodleViewController)
        navigationController.modalPresentationStyle = .fullScreen
        navigationController.view.backgroundColor = .white
        present(navigationController, animated: true)
    }
}

extension CollectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoManager.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellReuseIdentifier = "cell"
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseIdentifier, for: indexPath) as! CustomCollectionViewCell
        
        let index = indexPath.item
        let size = CGSize(width: 100, height: 100)
        
        photoManager.makePhotoData(index: index,
                                   size: size) { image in
            DispatchQueue.main.async {
                if let image = image {
                    cell.configure(with: image)
                }
            }
        }
        
        return cell
    }
}

extension CollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_: UICollectionView, layout: UICollectionViewLayout, sizeForItemAt: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 100)
    }
}
