//
//  XibView.swift
//  PagingScrollTab
//
//  Created by YamamuraRyoga on 2020/02/18.
//  Copyright © 2020 y.ryoga. All rights reserved.
//

import UIKit

public class XibView: UIView, NibProtocol {
    @IBOutlet private(set) var view: UIView! {
        didSet {
            view.frame = bounds
            addSubview(view)
            view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        }
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        loadNib()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadNib()
    }
    
    public func loadNib() {
        nib.instantiate(withOwner: self, options: nil)
    }
}

public protocol NibProtocol {
    static var nib: UINib { get }
    var nib: UINib { get }
}

public extension NibProtocol where Self: ClassNameProtocol {
    static var nib: UINib {
        return UINib(nibName: className, bundle: Bundle.main)
    }
    
    var nib: UINib {
        return UINib(nibName: className, bundle: Bundle.main)
    }
}

public protocol ClassNameProtocol {
    static var className: String { get }
    var className: String { get }
}

public extension ClassNameProtocol {
    static var className: String {
        return String(describing: self)
    }
    
    var className: String {
        return type(of: self).className
    }
}

extension NSObject: ClassNameProtocol {}



