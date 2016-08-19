//
//  PhotosViewController.swift
//  Photorama
//
//  Created by Xavi Moll on 18/08/16.
//  Copyright © 2016 Xavi Moll. All rights reserved.
//

import UIKit

class PhotosViewController: UIViewController, UICollectionViewDelegate {
    
    @IBOutlet var collectionView: UICollectionView!
    var store: PhotoStore!
    let photosDataSource = PhotoDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = photosDataSource
        collectionView.delegate = self
        
        store.fetchRecentPhotos() {
            (photosResult) -> Void in
            
            NSOperationQueue.mainQueue().addOperationWithBlock {
                switch photosResult {
                case let .Success(photos):
                    print("Successfully found \(photos.count) recent photos.")
                    self.photosDataSource.photos = photos
                case let .Failure(error):
                    self.photosDataSource.photos.removeAll()
                    print("Error fetching recent photos: \(error)")
                }
                self.collectionView.reloadSections(NSIndexSet(index: 0))
            }
        }
    }
    
    func collectionView(collectionView: UICollectionView, willDisplayCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        let photo = photosDataSource.photos[indexPath.row]
        
        // Download the image data, wich could take some time
        store.fetchImageForPhoto(photo) { (result) -> Void in
            NSOperationQueue.mainQueue().addOperationWithBlock {
                // The index path for the photo might have changed between the
                // time the request started and finished, so find the most
                // recent index path
                let photoIndex = self.photosDataSource.photos.indexOf(photo)!
                let photoIndexPath = NSIndexPath(forRow: photoIndex, inSection: 0)
                
                // When the request finishes, only update the cell if it's still visible
                if let cell = self.collectionView.cellForItemAtIndexPath(photoIndexPath) as? PhotoCollectionViewCell {
                    cell.updateWithImage(photo.image)
                }
            }
        }
    }
    
}
