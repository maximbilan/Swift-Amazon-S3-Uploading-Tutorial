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
		uploadButton.isHidden = true
		activityIndicator.startAnimating()
		
		let accessKey = "PLEASE_ENTER_YOUR_AMAZON_S3_ACCESS_KEY"
		let secretKey = "PLEASE_ENTER_YOUR_AMAZON_S3_SECRET_KEY"
		
		let credentialsProvider = AWSStaticCredentialsProvider(accessKey: accessKey, secretKey: secretKey)
		let configuration = AWSServiceConfiguration(region:AWSRegionType.USEast1, credentialsProvider:credentialsProvider)
		
		AWSServiceManager.default().defaultServiceConfiguration = configuration
		
		let S3BucketName = "BUCKET_NAME"
		let remoteName = "test.jpg"
		let fileURL = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(remoteName)
		let image = UIImage(named: "test")
		let data = UIImageJPEGRepresentation(image!, 0.9)
		do {
			try data?.write(to: fileURL)
		}
		catch {}
		
		let uploadRequest = AWSS3TransferManagerUploadRequest()!
		uploadRequest.body = fileURL
		uploadRequest.key = remoteName
		uploadRequest.bucket = S3BucketName
		uploadRequest.contentType = "image/jpeg"
		uploadRequest.acl = .publicRead
		
		let transferManager = AWSS3TransferManager.default()
		
		transferManager.upload(uploadRequest).continueWith { [weak self] (task) -> Any? in
			DispatchQueue.main.async {
				self?.uploadButton.isHidden = false
				self?.activityIndicator.stopAnimating()
			}
			
			if let error = task.error {
				print("Upload failed with error: (\(error.localizedDescription))")
			}
			
			if task.result != nil {
				let url = AWSS3.default().configuration.endpoint.url
				let publicURL = url?.appendingPathComponent(uploadRequest.bucket!).appendingPathComponent(uploadRequest.key!)
				if let absoluteString = publicURL?.absoluteString {
					print("Uploaded to:\(absoluteString)")
				}
			}
			
			return nil
		}
	}
	
}

