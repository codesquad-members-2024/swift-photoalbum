//
//  DoodleViewController.swift
//  photoAlbum
//
//  Created by 조호근 on 4/25/24.
//

import UIKit

class DoodleViewController: UIViewController {
    var doodles: [Doodle] = []
    
    lazy var collectionView: UICollectionView = {
        let cellReuseIdentifier = "doodleCell"
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 110, height: 50)
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .darkGray
        cv.dataSource = self
        cv.delegate = self
        cv.register(DoodleCollectionViewCell.self, forCellWithReuseIdentifier: cellReuseIdentifier)
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        doodles = loadDoodles()
        collectionView.reloadData()
        
        setupView()
        setupNavigationBar()
        setupGesture()
    }
    
    private func setupView() {
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func setupGesture() {
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(_:)))
        collectionView.addGestureRecognizer(longPressRecognizer)
    }
    
    @objc func handleLongPress(_ gestureRecognizer: UILongPressGestureRecognizer) {
        if gestureRecognizer.state != .began {
            return
        }
        
        let point = gestureRecognizer.location(in: collectionView)
        if let indexPath = collectionView.indexPathForItem(at: point) {
            collectionView.selectItem(at: indexPath, animated: true, scrollPosition: [])
            
            let menu = UIMenuController.shared
            let saveAction = UIMenuItem(title: "Save", action: #selector(saveImage(_:)))
            menu.menuItems = [saveAction]
            
            if let cell = collectionView.cellForItem(at: indexPath) {
                menu.setTargetRect(cell.frame, in: collectionView)
                menu.setMenuVisible(true, animated: true)
            }
        }
    }
    
    @objc func saveImage(_ sender: Any) {
        guard let indexPath = collectionView.indexPathsForSelectedItems?.first,
              indexPath.row < doodles.count else {
            return
        }
        
        let doodle = doodles[indexPath.row]
        if let url = URL(string: doodle.image) {
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data,
                      let image = UIImage(data: data), error == nil else { return }
                
                DispatchQueue.main.async {
                    UIImageWriteToSavedPhotosAlbum(image, self, #selector(self.image(_:didFinishSavingWithError:contextInfo:)), nil)
                    self.dismiss(animated: true)
                }
            }.resume()
        }
    }

    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            print("[에러]: \(error.localizedDescription)")
        } else {
            print("성공적으로 이미지가 저장되었습니다.")
        }
    }
    
    private func setupNavigationBar() {
        title = "Doodles"
        let closeBtn = UIBarButtonItem(title: "Close", style: .plain, target: self, action: #selector(closeTapped))
        navigationItem.rightBarButtonItem = closeBtn
    }
    
    private func loadDoodles() -> [Doodle] {
        guard let url = Bundle.main.url(forResource: "doodle", withExtension: "json"),
              let data = try? Data(contentsOf: url) else {
            return []
        }
        
        let decoder = JSONDecoder()
        return (try? decoder.decode([Doodle].self, from: data)) ?? []
    }
    
    @objc func closeTapped() {
        dismiss(animated: true)
    }
}

extension DoodleViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return doodles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellReuseIdentifier = "doodleCell"
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseIdentifier, for: indexPath) as! DoodleCollectionViewCell
        let doodle = doodles[indexPath.row]
        cell.configure(with: doodle)
        return cell
    }
}

extension DoodleViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
    }
}
