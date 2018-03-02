//
//  ZoomViewController.swift
//  SwiftMVVM
//
//  Created by Sanchez Custodio, Abel on 02/03/2018.
//  Copyright © 2018 acsanchezcu. All rights reserved.
//

import UIKit

class ZoomViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView! {
        didSet {
            scrollView.minimumZoomScale = scrollView.zoomScale
            scrollView.maximumZoomScale = 3
            scrollView.delegate = self
        }
    }
    
    // MARK: - Properties
    
    let imageUrl: String
    
    // MARK: - Init
    
    init(imageUrl: String) {
        self.imageUrl = imageUrl
        
        super.init(nibName: String(describing: ZoomViewController.self), bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        imageView.loadImageUrl(imageUrl)
    }

    // MARK: - Actions
    
    @IBAction func closeButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

extension ZoomViewController: UIScrollViewDelegate {
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
}
