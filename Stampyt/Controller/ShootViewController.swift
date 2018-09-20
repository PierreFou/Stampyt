//
//  ShootViewController.swift
//  Stampyt
//
//  Created by Pierre on 17/09/2018.
//  Copyright © 2018 Pierre. All rights reserved.
//

import UIKit
import AVFoundation

class ShootViewController: UIViewController {

    @IBOutlet weak var photo1: UIImageView!
    @IBOutlet weak var photo2: UIImageView!
    @IBOutlet weak var cameraView: UIView!
    @IBOutlet weak var takePictureButton: UIButton!
    
    let captureSession = AVCaptureSession()
    var camera: AVCaptureDevice?
    var photoOutput: AVCapturePhotoOutput?
    var cameraPreviewLayer: AVCaptureVideoPreviewLayer?
    var photoTake: UIImage?
    var imageViewArray = [UIImageView]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCamera()
        setupImageViewArray()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        clearImagesView()
        
        // Sinon on y affecte les images que l'on possède aux index associés
        for (index, image) in ShootingService.shared.originalPictures.enumerated() {
            let imageView = imageViewArray[index]
            imageView.backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
            imageView.image = image
        }
            
        // Lorsque nous avons toutes les images qui sont affectés, on entame le traitement d'envoi
        if ShootingService.shared.originalPictures.count == imageViewArray.count {
            performSegue(withIdentifier: Constants.Identifier.SegueSendProduct, sender: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.Identifier.SegueImagePreview, photoTake != nil, let imageVC = segue.destination as? ImagePreviewViewController {
            imageVC.imageToShow = photoTake
        } 
    }
    
    @IBAction func takePicture() {
        photoOutput?.capturePhoto(with: AVCapturePhotoSettings(), delegate: self)
    }
    
    func clearImagesView() {
        imageViewArray.forEach { (imageView) in
            imageView.backgroundColor = #colorLiteral(red: 0.2215260152, green: 0.2215260152, blue: 0.2215260152, alpha: 1)
            imageView.image = nil
        }
    }
    
    // Ajoute tous les imageView de manière à rendre le process dynamique (ex si on veut ajouter plus de 2 photos par la suite)
    func setupImageViewArray() {
        imageViewArray.append(photo1)
        imageViewArray.append(photo2)
    }
    
    // Initialise tous les composants liés à la caméra : vue, appareil photo, prise de la photo
    func setupCamera() {
        // On utilise la caméra arrière pour une question de qualité et de logique
        camera = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: .video, position: AVCaptureDevice.Position.back).devices.first
        
        if camera != nil {
            setupCapture()
            setupLayer()
            captureSession.startRunning()
        }
    }
    
    // Initialise les composants pour la capture
    func setupCapture() {
        guard camera != nil else { return }
        
        do {
            let captureDeviceInput = try AVCaptureDeviceInput(device: camera!)
            
            captureSession.sessionPreset = .photo
            if captureSession.canAddInput(captureDeviceInput) {
                captureSession.addInput(captureDeviceInput)
            }
 
            photoOutput = AVCapturePhotoOutput()
            photoOutput?.setPreparedPhotoSettingsArray([AVCapturePhotoSettings(format: [AVVideoCodecKey: AVVideoCodecType.jpeg])], completionHandler: nil)
            
            if captureSession.canAddOutput(photoOutput!) {
                captureSession.addOutput(photoOutput!)
            }
        } catch {
            print(error)
        }
    }

    // Initialise la vue de la caméra
    func setupLayer() {
        cameraPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        cameraPreviewLayer?.videoGravity = .resize
        cameraPreviewLayer?.connection?.videoOrientation = .landscapeRight
        cameraPreviewLayer?.frame = cameraView.bounds
        cameraView.layer.insertSublayer(cameraPreviewLayer!, at: 0)
    }
    
}

extension ShootViewController: AVCapturePhotoCaptureDelegate {
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        if error != nil {
            print(error!.localizedDescription)
        }
        if let dataImage = photo.cgImageRepresentation() {
            photoTake = UIImage(cgImage: dataImage.takeUnretainedValue(), scale: 1, orientation: .up)
            performSegue(withIdentifier: Constants.Identifier.SegueImagePreview, sender: nil)
        }
    }
}
