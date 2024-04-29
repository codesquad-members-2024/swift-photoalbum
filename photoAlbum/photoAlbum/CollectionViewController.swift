//
//  CollectionViewController.swift
//  photoAlbum
//
//  Created by 조호근 on 4/22/24.
//

import UIKit

class CollectionViewController: UIViewController {
    
    var photoManager: PhotoManager!
    var videoManager: VideoManager!
    
    
    @IBOutlet weak var doneBtn: UIBarButtonItem!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        photoManager = PhotoManager()
        videoManager = VideoManager()
        registerNotification()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.allowsMultipleSelection = true
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
    
    @IBAction func doneBtnTapped(_ sender: Any) {
        let size = CGSize(width: 100.0, height: 100.0)
        videoManager.build(outputSize: size, collectionView: collectionView)
    }
}

extension CollectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoManager.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellReuseIdentifier = "cell"
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseIdentifier, for: indexPath) as! CustomCollectionViewCell
        
        let cellBackgroundView = UIView()
        cellBackgroundView.backgroundColor = UIColor.red
        cell.selectedBackgroundView = cellBackgroundView
        
        let index = indexPath.item
        let size = CGSize(width: 100, height: 100)
        
        photoManager.makePhotoData(index: index, size: size) { photoInfo in
            DispatchQueue.main.async {
                cell.configure(with: photoInfo)
            }
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        updateDoneButtonState()
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        updateDoneButtonState()
    }
    
    private func updateDoneButtonState() {
        let selectedItemsCount = collectionView.indexPathsForSelectedItems?.count ?? 0
        doneBtn.isEnabled = selectedItemsCount >= 3
    }
}

extension CollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_: UICollectionView, layout: UICollectionViewLayout, sizeForItemAt: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 100)
    }
}
