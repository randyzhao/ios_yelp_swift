//
//  InfiniteScroll.swift
//  Yelp
//
//  Created by randy_zhao on 5/27/16.
//  Copyright © 2016 Timothy Lee. All rights reserved.
//

import Foundation
import UIKit

extension BusinessViewController: UIScrollViewDelegate {
  func scrollViewDidScroll(scrollView: UIScrollView) {
    if (!isMoreDataLoading) {
      let scrollViewContentHeight = businessTableView.contentSize.height
      let scrollOffsetThreshold = scrollViewContentHeight - businessTableView.bounds.size.height
      
      // When the user has scrolled past the threshold, start requesting
      if(scrollView.contentOffset.y > scrollOffsetThreshold && businessTableView.dragging) {
        isMoreDataLoading = true
        
        // Update position of loadingMoreView, and start loading indicator
        let frame = CGRectMake(0, businessTableView.contentSize.height, businessTableView.bounds.size.width, InfiniteScrollActivityView.defaultHeight)
        loadingMoreView?.frame = frame
        loadingMoreView!.startAnimating()
        
        loadMoreData()
      }
    }
  }
}