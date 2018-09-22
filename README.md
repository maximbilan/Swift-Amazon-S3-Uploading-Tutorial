# How to upload a file to Amazon S3 using Swift

I would like to share a simple tutorial how to upload a to <a href="https://github.com/aws/aws-sdk-ios">Amazon S3</a> in <i>iOS</i> using <i>Swift</i>. Let’s go.

![alt tag](https://raw.github.com/maximbilan/Swift-Amazon-S3-Uploading-Tutorial/master/img/img1.png)

We need to add <a href="https://github.com/aws/aws-sdk-ios">Amazon S3</a> framework to your project.<br>
In this example I will do this with helping <a href="https://cocoapods.org">Cocoapods</a>.

Create a <i>Podfile</i>:

<pre>
platform :ios, '8.0'
inhibit_all_warnings!
use_frameworks!
target 'AmazonS3Upload' do
pod 'AWSS3'
end
</pre>

Run the next command from <i>Terminal</i>:

<pre>
pod install
</pre>

Open the generated workspace. And after that we can implement uploading of files using frameworks from <i>Pods</i>.

We need to import 2 modules:

<pre>
import AWSS3
import AWSCore
</pre>

Set up a <i>AWS configuration</i>  using your <i>credentials</i>. For example:

<pre>
let accessKey = "..."
let secretKey = "..."
let credentialsProvider = AWSStaticCredentialsProvider(accessKey: accessKey, secretKey: secretKey)
let configuration = AWSServiceConfiguration(region: AWSRegionType.usEast1, credentialsProvider: credentialsProvider)
AWSServiceManager.default().defaultServiceConfiguration = configuration
</pre>

Create an upload request:

<pre>
let url = ...URL to your file...
let remoteName = "Name of uploaded file"
let S3BucketName = "Name of your bucket on Amazon S3"
let uploadRequest = AWSS3TransferManagerUploadRequest()!
uploadRequest.body = url
uploadRequest.key = remoteName
uploadRequest.bucket = S3BucketName
uploadRequest.contentType = "image/jpeg"
uploadRequest.acl = .publicRead
</pre>

And upload using <i>AWSS3TransferManager</i>.

<pre>
let transferManager = AWSS3TransferManager.default()
transferManager?.upload(uploadRequest).continue({ (task: AWSTask<AnyObject>) -> Any? in
  if let error = task.error {
    print("Upload failed with error: (\(error.localizedDescription))")
  }
  if let exception = task.exception {
    print("Upload failed with exception (\(exception))")
  }
  if task.result != nil {
    let url = AWSS3.default().configuration.endpoint.url
    let publicURL = url?.appendingPathComponent(uploadRequest.bucket!).appendingPathComponent(uploadRequest.key!)
    print("Uploaded to:\(publicURL)")
  }
  return nil
})
</pre>
