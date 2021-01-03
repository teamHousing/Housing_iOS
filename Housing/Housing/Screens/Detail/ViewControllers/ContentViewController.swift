//
//  ContentViewController.swift
//  Housing
//
//  Created by 노한솔 on 2021/01/04.
//

import UIKit

import SegementSlide


class ContentViewController: UITableViewController, SegementSlideContentScrollViewDelegate {

		

		@objc var scrollView: UIScrollView {
				return tableView
		}

}
