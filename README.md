# Swift 3 Upload file to Amazon S3

would like to share simple tutorial how to upload file to Amazon S3 in iOS using Swift 3. Let’s go.

1. We need to add Amazon S3 framework to your project. In this example I will do this with helping Cocoapods.

2. Create a Podfile:

3. Run the next command from Terminal:

4. Open the generated workspace. And after that we can implement uploading of files using frameworks from Pods.

5. We need to import 2 modules:

6. Setup AWS configuration using your credentials. For example:

7. Create upload request:

8. And upload using AWSS3TransferManager.

That’s all. The full worked example you can found here.
