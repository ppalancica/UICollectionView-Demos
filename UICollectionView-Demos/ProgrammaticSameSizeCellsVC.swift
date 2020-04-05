//
//  ProgrammaticSameSizeCellsVC.swift
//  UICollectionView-Demos
//
//  Created by Pavel Palancica on 4/5/20.
//  Copyright © 2020 I Dev TV. All rights reserved.
//

import UIKit

class ProgrammaticSameSizeCellsVC: UIViewController {
    
    @IBOutlet private weak var collectionView: UICollectionView! {
        didSet {
            let layout = UICollectionViewFlowLayout()
            // If we instead use the Layout setup in storyboard - it must be have `estimatedItemSize` set to None there.
            // Leaving it to default / Automatic - would cause issues.
            layout.estimatedItemSize = .zero
            layout.minimumInteritemSpacing = 2
            layout.minimumLineSpacing = 2
            collectionView.collectionViewLayout = layout
        }
    }
    
    private let items = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
    
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

        // view.frame.size.width - this is not reliable here
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = constantCellSize(collectionViewWidth: UIScreen.main.bounds.size.width, layout: layout)
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
    
    private func constantCellSize(collectionViewWidth: CGFloat, layout: UICollectionViewLayout) -> CGSize {
        guard let layout = layout as? UICollectionViewFlowLayout else { return .zero }
        let cellWidth = (collectionViewWidth - layout.minimumInteritemSpacing * 2) / 3
        let cellHeight = cellWidth
        
        return CGSize(width: cellWidth, height: cellHeight)
    }
}
