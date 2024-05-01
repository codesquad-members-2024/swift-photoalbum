//
//  VideoManager.swift
//  photoAlbum
//
//  Created by 조호근 on 4/30/24.
//
import UIKit
import Photos

struct VideoManager {
    func build(outputSize: CGSize, collectionView: UICollectionView) {
        guard let videoOutputURL = prepareFile() else { return }
        guard let videoWriter = configureVideoWriter(outputURL: videoOutputURL, outputSize: outputSize) else { return }
        createVideoFromImages(collectionView: collectionView, videoWriter: videoWriter, outputSize: outputSize, videoOutputURL: videoOutputURL)
    }
    
    private func prepareFile() -> URL? {
        let fileManager = FileManager.default
        guard let documentDirectory = fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first else {
            return nil
        }

        let videoOutputURL = documentDirectory.appendingPathComponent("OutputVideo.mp4")

        if fileManager.fileExists(atPath: videoOutputURL.path) {
            try? fileManager.removeItem(atPath: videoOutputURL.path)
        }
        
        return videoOutputURL
    }
    
    private func configureVideoWriter(outputURL: URL, outputSize: CGSize) -> AVAssetWriter? {
        guard let videoWriter = try? AVAssetWriter(outputURL: outputURL, fileType: .mp4) else { return nil }
        let outputSettings: [String: Any] = [
            AVVideoCodecKey: AVVideoCodecType.h264.rawValue,
            AVVideoWidthKey: outputSize.width,
            AVVideoHeightKey: outputSize.height
        ]

        if !videoWriter.canApply(outputSettings: outputSettings, forMediaType: .video) {
            return nil
        }

        let videoWriterInput = AVAssetWriterInput(mediaType: .video, outputSettings: outputSettings)
        videoWriter.add(videoWriterInput)
        return videoWriter
    }
    
    private func createVideoFromImages(collectionView: UICollectionView, videoWriter: AVAssetWriter, outputSize: CGSize, videoOutputURL: URL) {
        guard let videoWriterInput = videoWriter.inputs.first as? AVAssetWriterInput else { return }
        let pixelBufferAdaptor = createPixelBufferAdaptor(videoWriterInput: videoWriterInput, outputSize: outputSize)

        videoWriter.startWriting()
        videoWriter.startSession(atSourceTime: .zero)

        let mediaQueue = DispatchQueue(label: "mediaInputQueue")
        videoWriterInput.requestMediaDataWhenReady(on: mediaQueue) {
            self.writeImagesToVideo(collectionView: collectionView, videoWriterInput: videoWriterInput, pixelBufferAdaptor: pixelBufferAdaptor, outputSize: outputSize)
            self.finishWritingVideo(videoWriter: videoWriter, videoOutputURL: videoOutputURL)
        }
    }
    
    private func createPixelBufferAdaptor(videoWriterInput: AVAssetWriterInput, outputSize: CGSize) -> AVAssetWriterInputPixelBufferAdaptor {
        let attributes: [String: Any] = [
            kCVPixelBufferPixelFormatTypeKey as String: NSNumber(value: kCVPixelFormatType_32ARGB),
            kCVPixelBufferWidthKey as String: outputSize.width,
            kCVPixelBufferHeightKey as String: outputSize.height
        ]
        return AVAssetWriterInputPixelBufferAdaptor(assetWriterInput: videoWriterInput, sourcePixelBufferAttributes: attributes)
    }
    
    private func writeImagesToVideo(collectionView: UICollectionView, videoWriterInput: AVAssetWriterInput, pixelBufferAdaptor: AVAssetWriterInputPixelBufferAdaptor, outputSize: CGSize) {
        let fps: Int32 = 1
        var frameCount: Int64 = 0

        DispatchQueue.main.sync {
            let indexPaths = collectionView.indexPathsForSelectedItems ?? []
            let imageCells = indexPaths.map { collectionView.cellForItem(at: $0) as! CustomCollectionViewCell }
            let images = imageCells.map { $0.imageView.image! }

            for image in images {
                if videoWriterInput.isReadyForMoreMediaData {
                    let presentationTime = CMTime(value: frameCount, timescale: fps)
                    if !self.appendImageToVideo(pixelBufferAdaptor: pixelBufferAdaptor, image: image, presentationTime: presentationTime, outputSize: outputSize) {
                        break
                    }
                    frameCount += 1
                }
            }
        }
        videoWriterInput.markAsFinished()
    }
    
    private func finishWritingVideo(videoWriter: AVAssetWriter, videoOutputURL: URL) {
        videoWriter.finishWriting {
            DispatchQueue.main.async {
                self.saveVideoToLibrary(videoURL: videoOutputURL)
            }
        }
    }
    
    private func saveVideoToLibrary(videoURL: URL) {
        PHPhotoLibrary.shared().performChanges({
            PHAssetChangeRequest.creationRequestForAssetFromVideo(atFileURL: videoURL)
        }) { saved, error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }

    private func appendImageToVideo(pixelBufferAdaptor: AVAssetWriterInputPixelBufferAdaptor, image: UIImage, presentationTime: CMTime, outputSize: CGSize) -> Bool {
        var pixelBufferOut: CVPixelBuffer?
        guard let pixelBufferPool = pixelBufferAdaptor.pixelBufferPool else {
            return false
        }
        let status = CVPixelBufferPoolCreatePixelBuffer(nil, pixelBufferPool, &pixelBufferOut)
        guard status == kCVReturnSuccess, let pixelBuffer = pixelBufferOut else {
            return false
        }

        let success = renderImageToPixelBuffer(pixelBuffer: pixelBuffer, image: image, size: outputSize)
        if success {
            return pixelBufferAdaptor.append(pixelBuffer, withPresentationTime: presentationTime)
        }
        return false
    }

    
    private func renderImageToPixelBuffer(pixelBuffer: CVPixelBuffer, image: UIImage, size: CGSize) -> Bool {
        CVPixelBufferLockBaseAddress(pixelBuffer, [])
        defer { CVPixelBufferUnlockBaseAddress(pixelBuffer, []) }
        guard let context = CGContext(data: CVPixelBufferGetBaseAddress(pixelBuffer), width: Int(size.width), height: Int(size.height), bitsPerComponent: 8, bytesPerRow: CVPixelBufferGetBytesPerRow(pixelBuffer), space: CGColorSpaceCreateDeviceRGB(), bitmapInfo: CGImageAlphaInfo.premultipliedFirst.rawValue) else { return false }
        context.draw(image.cgImage!, in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        return true
    }
}
