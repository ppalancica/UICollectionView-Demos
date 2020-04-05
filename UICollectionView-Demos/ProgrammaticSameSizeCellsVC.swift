//
//  ProgrammaticSameSizeCellsVC.swift
//  UICollectionView-Demos
//
//  Created by Pavel Palancica on 4/5/20.
//  Copyright © 2020 I Dev TV. All rights reserved.
//

import UIKit

class ProgrammaticSameSizeCellsVC: UIViewController {
    
    private lazy var collectionView: UICollectionView = createCollectionView()
        
    private let items = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupCollectionView()
    }
    
    func setupCollectionView() {
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
        
        let nibName = String(describing: CustomCollectionViewCell.self)
        let nib = UINib(nibName: nibName, bundle: nil)
        collectionView.register(
            nib,
            forCellWithReuseIdentifier: String(describing: CustomCollectionViewCell.self)
        )
        collectionView.dataSource = self

        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = constantCellSize(collectionViewWidth: view.frame.size.width, layout: layout)
    }
}

extension ProgrammaticSameSizeCellsVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellReuseIentifier = String(describing: CustomCollectionViewCell.self)
        
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: cellReuseIentifier,
            for: indexPath
        ) as? CustomCollectionViewCell else { return UICollectionViewCell() }

        let item = items[indexPath.item]
        
        cell.configureWithItem(item)
        cell.backgroundColor = indexPath.item % 2 == 0 ? .red : .blue
        
        return cell
    }
}

extension ProgrammaticSameSizeCellsVC {
    
    private func createCollectionView() -> UICollectionView {
        let layout = UICollectionViewFlowLayout()
        // If we instead use the Layout setup in storyboard - it must be have `estimatedItemSize` set to None there.
        // Leaving it to default / Automatic - would cause issues.
        // Explictly setting it to .zero in code is optional
        layout.estimatedItemSize = .zero
        layout.minimumInteritemSpacing = 2
        layout.minimumLineSpacing = 2
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        
        return collectionView
    }
    
    private func constantCellSize(collectionViewWidth: CGFloat, layout: UICollectionViewLayout) -> CGSize {
        guard let layout = layout as? UICollectionViewFlowLayout else { return .zero }
        let cellWidth = (collectionViewWidth - layout.minimumInteritemSpacing * 2) / 3
        let cellHeight = cellWidth
        
        return CGSize(width: cellWidth, height: cellHeight)
    }
}
