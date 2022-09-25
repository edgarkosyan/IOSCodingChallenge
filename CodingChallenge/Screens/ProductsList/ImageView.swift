//
//  ImageView.swift
//  CodingChallenge
//
//  Created by Edgar on 24.09.22.
//

import SwiftUI

struct ImageView: View {
    @ObservedObject var viewModel: ImageViewModel
    
    init(urlString: String?) {
        self.viewModel = ImageViewModel(urlString: urlString)
    }
    var body: some View {
        if let image = viewModel.image {
            image
                .resizable()
                .scaledToFit()
        } else {
            Image(systemName: "photo")
        }
    }
    
    class ImageViewModel: ObservableObject {
        @Published var image: Image?
        
        private let urlString: String?
        private let downloadManager: DownloadManager
        private let imageChache: ImageCache
        
        init(urlString: String?, manager: DownloadManager = DownloadManager.shared, imageChache: ImageCache = ImageCache.shared) {
            self.urlString = urlString
            self.downloadManager = manager
            self.imageChache = imageChache
            loadData()
        }
        
        private func loadData() {
            if loadImageFromCache() {
                return
            }
            Task {
                await downloadImage()
            }
        }
        
        private func loadImageFromCache() -> Bool {
            guard let urlString = urlString else { return false }
            guard let cacheImage = imageChache.get(forKey: urlString) else { return false }
            image = Image(uiImage: cacheImage)
            return true
        }
        
        private func downloadImage() async {
            guard let url = urlString else { return print("url of image is nil") }
            do {
                let data = try await downloadManager.downloadImageData(urlString: url)
                if let image = UIImage(data: data) {
                    await MainActor.run(body: {
                        imageChache.set(forKey: url, image: image)
                        self.image = Image(uiImage: image)
                    })
                } else {
                    print("Image Data Error")
                }
            } catch {
                print("Error: \(error)")
            }
        }
    }
}

struct ImageView_Previews: PreviewProvider {
    static var previews: some View {
        ImageView(urlString: "")
    }
}
