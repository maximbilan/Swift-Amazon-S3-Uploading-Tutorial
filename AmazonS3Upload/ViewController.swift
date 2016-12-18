//
//  ViewController.swift
//  AmazonS3Upload
//
//  Created by Maxim on 12/18/16.
//  Copyright © 2016 maximbilan. All rights reserved.
//

import UIKit

import AWSS3
import AWSCore

class ViewController: UIViewController {

	@IBOutlet weak var uploadButton: UIButton!
	@IBOutlet weak var activityIndicator: UIActivityIndicatorView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
	}

	@IBAction func uploadButtonAction(_ sender: UIButton) {
		let accessKey = "PLEASE_ENTER_YOUR_AMAZON_S3_ACCESS_KEY"
		let secretKey = "PLEASE_ENTER_YOUR_AMAZON_S3_SECRET_KEY"
		
		let credentialsProvider = AWSStaticCredentialsProvider(accessKey: accessKey, secretKey: secretKey)
		let configuration = AWSServiceConfiguration(region:AWSRegionType.usEast1, credentialsProvider:credentialsProvider)
		
		AWSServiceManager.default().defaultServiceConfiguration = configuration
		
		let S3BucketName = "BUCKET_NAME"
		let remoteName = "test"
	}

}

