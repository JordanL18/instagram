//
//  Cell.swift
//  Instagram
//
//

import UIKit

class Cell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    private let avatarImage = UIImageView()
    private let timeLabel = UILabel()
    private  let descrLabel = UILabel()
    private let nameField = UILabel()

    var likes = String()
    var timeStamp: TimeInterval?  {
        
        
        didSet {
            if let timeStamp = timeStamp {
                let myTime = TimeInterval(timeStamp)
                let time = NSDate(timeIntervalSince1970: myTime)
                let formatter = DateFormatter()
                
                formatter.timeZone = TimeZone.current
                
                formatter.dateFormat = "yyyy-MM-dd HH:mm"
                let dateString = formatter.string(from: time as Date)
                
                timeLabel.text = dateString
            }
            else {
                timeLabel.text = "Secret Date"
            }
        }
    }
    
    
    private var photo = UIImageView()

    
    var avatarUrl: String? {
        didSet {
        var sessionA = URLSession(configuration: .default)
        
        var url = URL(string: avatarUrl!)
        let download = sessionA.dataTask(with: url!) { (data, response, error) in
            if let e = error {
                print("Error downloading photo: \(e)")
            }else{
                if (response as? HTTPURLResponse) != nil {
                    if let imageData = data {
                        let image = UIImage(data: imageData)
                        DispatchQueue.main.async {
                            self.avatarImage.image = image
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

        
        
    


    
    var descr: String?  {
        didSet {
            if let descr = descr {
            descrLabel.text = descr
            }
            else {
                descrLabel.text = "No Description"
            }
        }
        
        
    }


    var name: String? {
        didSet {
            if let name = name {
                nameField.text = name
                
            }
            else {
                nameField.text = "anonymous"
                
            }
        }
    }

    
    
    var imageUrl: String? {
        didSet {

                var sessionA = URLSession(configuration: .default)
                
                var url = URL(string: imageUrl!)
                let download = sessionA.dataTask(with: url!) { (data, response, error) in
                    if let e = error {
                        print("Error downloading photo: \(e)")
                    }else{
                        if (response as? HTTPURLResponse) != nil {
                            if let imageData = data {
                                let image = UIImage(data: imageData)
                                DispatchQueue.main.async {
                                    self.photo.image = image
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
    
    

    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
        let neededWidth = self.frame.width/12
        
        avatarImage.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(avatarImage)
        avatarImage.layer.cornerRadius = neededWidth/2
        avatarImage.layer.masksToBounds = false
        avatarImage.layer.borderWidth = 1
        avatarImage.layer.borderColor = UIColor.black.cgColor
        avatarImage.clipsToBounds = true
        
        avatarImage.anchor(top: self.topAnchor, leading: self.leadingAnchor, bottom: nil, trailing: nil, padding: UIEdgeInsetsMake(10,5,0,0), size: .init(width:neededWidth, height: neededWidth))

        
        
        self.addSubview(nameField)
        nameField.font = UIFont.boldSystemFont(ofSize: 18)
        nameField.textColor = .black
        nameField.translatesAutoresizingMaskIntoConstraints = false
        nameField.anchor(top: self.topAnchor, leading: avatarImage.trailingAnchor, bottom: nil, trailing: self.trailingAnchor, padding: UIEdgeInsetsMake(13, 5, 0, 0))
        nameField.text = "CoursePath"
        
        
        
        self.addSubview(photo)
        photo.translatesAutoresizingMaskIntoConstraints = false
        photo.anchor(top: avatarImage.bottomAnchor, leading: self.leadingAnchor, bottom: nil, trailing: self.trailingAnchor,padding: UIEdgeInsetsMake(10, 0, 0, 0), size: .init(width: self.frame.width, height: self.frame.width*3/2) )
        
        
        
        descrLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(descrLabel)
        
        descrLabel.anchor(top: photo.bottomAnchor, leading: self.leadingAnchor, bottom: nil, trailing: self.trailingAnchor, padding: UIEdgeInsetsMake(5, 5, 0, 5))
        
        descrLabel.numberOfLines = 2
        descrLabel.lineBreakMode = .byWordWrapping
        descrLabel.text = "Heya!"
        
        
        
        
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(timeLabel)
        timeLabel.text = "SomeDate"
        timeLabel.textColor = UIColor.gray
        timeLabel.anchor(top: descrLabel.bottomAnchor, leading: self.leadingAnchor, bottom: nil, trailing: self.trailingAnchor, padding: .init(top: 5, left: 5, bottom: 0, right: 5))
        

     
            
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
