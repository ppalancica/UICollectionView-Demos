//
//  ProgrammaticDifferentSizeCellsVC.swift
//  UICollectionView-Demos
//
//  Created by Pavel Palancica on 4/5/20.
//  Copyright © 2020 I Dev TV. All rights reserved.
//

import UIKit

class ProgrammaticDifferentSizeCellsVC: UIViewController {
    
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
        collectionView.delegate = self
    }
}

extension ProgrammaticDifferentSizeCellsVC: UICollectionViewDataSource {
    
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

extension ProgrammaticDifferentSizeCellsVC: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = items[indexPath.item]
        print("Selected: \(item)")
    }
}

extension ProgrammaticDifferentSizeCellsVC: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return dynamicCellSize(indexPath: indexPath,
                               collectionViewWidth: view.frame.size.width,
                               layout: collectionViewLayout)
    }
}

extension ProgrammaticDifferentSizeCellsVC {
    
    private func dynamicCellSize(indexPath: IndexPath, collectionViewWidth: CGFloat, layout: UICollectionViewLayout) -> CGSize {
        let layout = layout as! UICollectionViewFlowLayout
        var cellWidth: CGFloat
        var cellHeight: CGFloat
        
        if indexPath.item % 4 == 0 {
            cellWidth = view.frame.size.width
            cellHeight = cellWidth
        } else {
            cellWidth = (view.frame.size.width - layout.minimumInteritemSpacing * 3) / 3
            cellHeight = cellWidth
        }
        
        return CGSize(width: cellWidth, height: cellHeight)
    }
}
