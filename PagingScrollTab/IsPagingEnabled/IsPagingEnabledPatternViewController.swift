//
//  IsPagingEnabledPatternViewController.swift
//  PagingScrollTab
//
//  Created by YamamuraRyoga on 2020/02/18.
//  Copyright © 2020 y.ryoga. All rights reserved.
//

import Foundation
import UIKit

final class IsPagingEnabledPatternViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    lazy var isPagingEnabledPatternView = IsPagingEnabledPatternView(frame: UIScreen.main.bounds)
    
    let cellWidth = 120

    override func viewDidLoad() {
        super.viewDidLoad()
        
        isPagingEnabledPatternView.collectionView.delegate = self
        isPagingEnabledPatternView.collectionView.dataSource = self
        isPagingEnabledPatternView.collectionView.register(UINib(nibName: "IsPagingEnabledPatternCell", bundle: nil), forCellWithReuseIdentifier: "IsPagingEnabledPatternCell")

        guard let flowLayout = isPagingEnabledPatternView.collectionView.collectionViewLayout as? IsPagingEnabledPatternCollectionViewFlowLayout else  { return }
        flowLayout.scrollDirection = .horizontal
        flowLayout.itemSize = CGSize(width: cellWidth, height: 80)
        flowLayout.minimumLineSpacing = 10
        let center = isPagingEnabledPatternView.center.x
        let leftInset = center - CGFloat(cellWidth/2)
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: leftInset, bottom: 0, right: 0)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    public override func loadView() {
        self.view = isPagingEnabledPatternView
    }
}

extension IsPagingEnabledPatternViewController {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = isPagingEnabledPatternView.collectionView.dequeueReusableCell(withReuseIdentifier: "IsPagingEnabledPatternCell", for: indexPath)
        cell.contentView.backgroundColor = UIColor.systemOrange
        return cell
    }
}
