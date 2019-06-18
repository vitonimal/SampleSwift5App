//
//  CameraViewController.swift
//  SampleApp
//
//  Created by Josh on 6/17/19.
//  Copyright © 2019 AccuV. All rights reserved.
//

import UIKit
import AVFoundation

class CameraViewController: UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate {

    @IBOutlet weak var photoPreview: UIImageView!
    @IBOutlet weak var imgContainer: UIImageView!
    var captureSession:AVCaptureSession?
    var previewLayer:CALayer!
    var captureDevice:AVCaptureDevice!
    var snap = false
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareCamera()
        // Do any additional setup after loading the view.
    }
    
    
    func prepareCamera() {
        captureSession = AVCaptureSession()
        captureSession?.sessionPreset = AVCaptureSession.Preset.photo
        let availableDevices = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: AVMediaType.video, position: .back).devices
        
        captureDevice = availableDevices.first
        beginSession();
    }
    
    @IBAction func takePhoto(_ sender: Any) {
        snap = true;
    }
    func beginSession() {
        do {
            let captureDeviceInput = try AVCaptureDeviceInput(device: captureDevice)
            captureSession?.addInput(captureDeviceInput)
        } catch {
            print(error.localizedDescription)
        }
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession!)
        self.view.layer.addSublayer(previewLayer)
        previewLayer.frame = imgContainer.frame
        
        captureSession?.startRunning()
        
        let dataOutput = AVCaptureVideoDataOutput()
        dataOutput.videoSettings = [(kCVPixelBufferPixelFormatTypeKey as NSString):NSNumber(value:kCVPixelFormatType_32BGRA)] as [String : Any]
        
        dataOutput.alwaysDiscardsLateVideoFrames = true
        
        if (captureSession?.canAddOutput(dataOutput))! {
            captureSession?.addOutput(dataOutput)
        }
        
        captureSession?.commitConfiguration()
        
        let queue = DispatchQueue(label: "com.accuv.captureQueueTest")
        dataOutput.setSampleBufferDelegate(self, queue: queue)
    }
    
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        if snap {
            snap = false
            if let image = self.getImageFromSampleBuffer(buffer: sampleBuffer) {
                DispatchQueue.main.async {
                    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
                }
            }
        }
    }
    
    func getImageFromSampleBuffer(buffer: CMSampleBuffer) -> UIImage? {
        if let pixelBuffer = CMSampleBufferGetImageBuffer(buffer) {
            let ciImage = CIImage(cvPixelBuffer: pixelBuffer)
            let context = CIContext()
            
            let imageRect = CGRect(x: 0, y: 0, width: CVPixelBufferGetWidth(pixelBuffer), height: CVPixelBufferGetHeight(pixelBuffer))
            
            
            if let image = context.createCGImage(ciImage, from: imageRect) {
                return UIImage(cgImage: image, scale: UIScreen.main.scale, orientation: .right)
            }
            return nil
        }
        return nil
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
