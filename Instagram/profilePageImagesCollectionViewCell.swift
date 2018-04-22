//
//  profilePageImagesCollectionViewCell.swift
//  Instagram
//
//

import UIKit

class profilePageImagesCollectionViewCell: UICollectionViewCell {
    
    
    
    let dan = ProfileViewController()
    
    private let image = UIImageView()
    
    var imageUrla: String? {
        
        didSet {
            var sessionA = URLSession(configuration: .default)
            guard let urlo = imageUrla else { return }
            var url = URL(string: urlo)
            let download = sessionA.dataTask(with: url!) { (data, response, error) in
                if let e = error {
                    print("Error downloading photo: \(e)")
                }else{
                    if (response as? HTTPURLResponse) != nil {
                        if let imageData = data {
                            let image = UIImage(data: imageData)
                            DispatchQueue.main.async {
                                self.image.image = image
                            }
                        } else {
                            print("Couldn't get image: Image is nil")
                        }
                    } else {
                        print("Couldn't get response code for some reason")
                    }
                }
                
            }
            download.resume()
            
        }
        
    }
    
 
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        image.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(image)
        
        
        image.anchor(top: self.topAnchor, leading: self.leadingAnchor, bottom: self.bottomAnchor, trailing: self.trailingAnchor)
        print("here")
        image.backgroundColor = .red
        
        
    }
    
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}


