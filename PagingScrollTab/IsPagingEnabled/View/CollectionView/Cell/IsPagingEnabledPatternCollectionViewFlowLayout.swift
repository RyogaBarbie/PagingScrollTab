//
//  IsPagingEnabledPatternCollectionViewFlowLayout.swift
//  PagingScrollTab
//
//  Created by YamamuraRyoga on 2020/02/18.
//  Copyright © 2020 y.ryoga. All rights reserved.
//

import UIKit

final class IsPagingEnabledPatternCollectionViewFlowLayout: UICollectionViewFlowLayout {
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        guard let collectionView = collectionView else { return proposedContentOffset }

       // sectionInsetを考慮して表示領域を拡大する
//        let expandedVisibleRect = CGRect(x: collectionView.contentOffset.x - (collectionView.bounds.width * 1),
//                                         y: 0,
//                                         width: (collectionView.bounds.width * 3),
//                                         height: collectionView.bounds.height)
        let expansionMargin = sectionInset.left + sectionInset.right
        let expandedVisibleRect = CGRect(x: collectionView.contentOffset.x - expansionMargin,
                                          y: 0,
                                          width: collectionView.bounds.width + (expansionMargin * 2),
                                          height: collectionView.bounds.height)

       // 表示領域の layoutAttributes を取得
        guard let targetAttributes = layoutAttributesForElements(in: expandedVisibleRect) else { return proposedContentOffset }

        let nextAttributes: UICollectionViewLayoutAttributes?
        if velocity.x == 0 {
            // スワイプせずに指を離した場合
            nextAttributes = layoutAttributesForNearbyCenterX(in: targetAttributes, collectionView: collectionView)
        } else if velocity.x > 0 {
            // 左スワイプ x座標で昇順にsort
            let sortedTargetAttributes = targetAttributes.sorted(by: { $0.frame.minX < $1.frame.minX })
            nextAttributes = sortedTargetAttributes[getNextAttributesIndex(velocityX: velocity.x, attributesCount: sortedTargetAttributes.count)]
        } else {
            // 右スワイプ　x座標で降順にsort
            let sortedTargetAttributes = targetAttributes.sorted(by: { $0.frame.minX > $1.frame.minX })
            nextAttributes = sortedTargetAttributes[getNextAttributesIndex(velocityX: velocity.x, attributesCount: sortedTargetAttributes.count)]
        }
        guard let attributes = nextAttributes else { return proposedContentOffset }

        // 画面左端からセルのマージンを引いた座標を返して画面中央に表示されるようにする
        let cellLeftMargin = (collectionView.bounds.width - attributes.bounds.width) * 0.5
        return CGPoint(x: attributes.frame.minX - cellLeftMargin, y: collectionView.contentOffset.y)
    }
    
    // 画面中央に一番近いセルの attributes を取得する
    private func layoutAttributesForNearbyCenterX(in attributes: [UICollectionViewLayoutAttributes], collectionView: UICollectionView) -> UICollectionViewLayoutAttributes? {
        let screenCenterX = collectionView.contentOffset.x + collectionView.bounds.width * 0.5
        let result = attributes.reduce((attributes: nil as UICollectionViewLayoutAttributes?, distance: CGFloat.infinity)) { result, attributes in
            let distance = attributes.frame.midX - screenCenterX
            return abs(distance) < abs(result.distance) ? (attributes, distance) : result
        }
        return result.attributes
    }
    
    private func getNextAttributesIndex(velocityX: CGFloat, attributesCount: Int) -> Int {
        switch abs(velocityX) {
        case 0..<1:
            return (3 < attributesCount) ? 3 : attributesCount - 1
        case 1..<2:
            return (4 < attributesCount) ? 4 : attributesCount - 1
        case 2..<3:
            return (6 < attributesCount) ? 6 : attributesCount - 1
        default:
            return attributesCount - 1
        }
    }
}
