import Foundation
import UIKit
import SDWebImage

class GitListTableViewCell: UITableViewCell {
    
    let gitRepoNameLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.boldSystemFont(ofSize: 16.0)
        return lbl
    }()
    
    let gitRepoStartCountLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 12.0)
        return lbl
    }()
    
    var gitRepoAuthorPhotoImage: UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFit
        imgView.clipsToBounds = true
        return imgView
    }()
    
    let gitRepoAuthorNameLabel: UILabel = {
        let lbl = UILabel()
        return lbl
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(gitRepoNameLabel)
        addSubview(gitRepoStartCountLabel)
        addSubview(gitRepoAuthorPhotoImage)
        addSubview(gitRepoAuthorNameLabel)
        
        gitRepoAuthorPhotoImage.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: nil, paddingTop: 5, paddingLeft: 5, paddingBottom: 5, paddingRight: 0, width: 50, height: 50, enableInsets: false)
        gitRepoNameLabel.anchor(top: topAnchor, left: gitRepoAuthorPhotoImage.rightAnchor, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, enableInsets: false)
        gitRepoStartCountLabel.anchor(top: gitRepoNameLabel.bottomAnchor, left: gitRepoAuthorPhotoImage.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, enableInsets: false)
        gitRepoAuthorNameLabel.anchor(top: topAnchor, left: nil, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 5, width: 0, height: 0, enableInsets: false)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with item:Item?) {
        if let item = item {
            self.gitRepoNameLabel.text = item.name
            self.gitRepoStartCountLabel.text = "Stars: \(String(describing: item.stargazersCount))"
            self.gitRepoAuthorPhotoImage.sd_imageIndicator = SDWebImageActivityIndicator.gray
            self.gitRepoAuthorPhotoImage.sd_setImage(with: URL(string:item.owner.avatarURL), placeholderImage: UIImage())
            self.gitRepoAuthorNameLabel.text = item.owner.login
            self.gitRepoNameLabel.isHidden = false
            self.gitRepoStartCountLabel.isHidden = false
            self.gitRepoAuthorPhotoImage.isHidden = false
            self.gitRepoAuthorNameLabel.isHidden = false
        } else {
            self.gitRepoNameLabel.isHidden = true
            self.gitRepoStartCountLabel.isHidden = true
            self.gitRepoAuthorPhotoImage.isHidden = true
            self.gitRepoAuthorNameLabel.isHidden = true
            let loading = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height))
            loading.style = .gray
            addSubview(loading)
            loading.startAnimating()
        }
    }
    
}
