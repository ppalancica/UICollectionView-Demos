//
//  MainViewController.swift
//  UICollectionView-Demos
//
//  Created by Pavel Palancica on 4/4/20.
//  Copyright © 2020 I Dev TV. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
        
    @IBOutlet private weak var collectionView: UICollectionView!
    
    private let items = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupCollectionView()
    }
    
    func setupCollectionView() {
        let nibName = String(describing: CustomCollectionViewCell.self)
        let nib = UINib(nibName: nibName, bundle: nil)
        collectionView.register(
            nib,
            forCellWithReuseIdentifier: String(describing: CustomCollectionViewCell.self)
        )
        collectionView.dataSource = self
        
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            let cellWidth = (view.frame.size.width - layout.minimumInteritemSpacing * 2) / 3
            let cellHeight = cellWidth
            layout.itemSize = CGSize(width: cellWidth, height: cellHeight)
            layout.estimatedItemSize = .zero
        }
    }
}

extension MainViewController: UICollectionViewDataSource {
    
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
