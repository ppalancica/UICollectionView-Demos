//
//  MainViewController.swift
//  UICollectionView-Demos
//
//  Created by Pavel Palancica on 4/4/20.
//  Copyright © 2020 I Dev TV. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBAction private func programmaticallySameSizesButtonTouched() {
        let programmaticSameSizeCellsVC = ProgrammaticSameSizeCellsVC()
        navigationController?.pushViewController(programmaticSameSizeCellsVC, animated: true)
    }
    
    @IBAction private func programmaticallyDifferentSizesButtonTouched() {
        let programmaticDifferentSizeCellsVC = ProgrammaticDifferentSizeCellsVC(nibName: "ProgrammaticDifferentSizeCellsVC", bundle: nil)
        navigationController?.pushViewController(programmaticDifferentSizeCellsVC, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}
