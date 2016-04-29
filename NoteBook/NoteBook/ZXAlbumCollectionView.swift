//
//  ZXAlbumCollectionView.swift
//  ZXBlog
//
//  Created by chris on 16/3/7.
//  Copyright © 2016年 apple. All rights reserved.
//

import UIKit
let ZXAlbumCollectionViewIdentifier = "ZXAlbumCollectionViewIdentifier"
let albumMargin:CGFloat = 10
let albumItemMargin:CGFloat = 5

class ZXAlbumCollectionView: UICollectionView,UICollectionViewDataSource,UICollectionViewDelegate {
    ///添加照片的闭包
    var addPhotoClosure:(()->())?
    var selectedImages:[UIImage] = [UIImage]()
    var flowLayout = UICollectionViewFlowLayout()
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: flowLayout)
        dataSource = self
        delegate = self
        registerClass(ZXAlbumCollectionViewCell.self, forCellWithReuseIdentifier: ZXAlbumCollectionViewIdentifier)
        let WH = (ScreenW - 2*albumItemMargin - 2*albumMargin)/3
        ///设置layout
        flowLayout.itemSize = CGSizeMake(WH, WH)
        flowLayout.minimumInteritemSpacing = albumItemMargin
        flowLayout.minimumLineSpacing = albumItemMargin
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
extension ZXAlbumCollectionView{
  //数据源方法
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if selectedImages.count == 0 || selectedImages.count == 9 {
            return selectedImages.count
        }
        return selectedImages.count + 1
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(ZXAlbumCollectionViewIdentifier, forIndexPath: indexPath) as! ZXAlbumCollectionViewCell
        if indexPath.item < selectedImages.count {
        cell.selectImg = selectedImages[indexPath.item]
        cell.closeBtn.hidden = false
        }else{
            cell.selectImg = UIImage(named: "compose_pic_add")
            cell.closeBtn.hidden = true
        }
        cell.deleteCloure = {
            self.selectedImages.removeAtIndex(indexPath.item)
            collectionView.reloadData()
            
        }
        return cell
        
    }
    //对外添加图片的接口
    func appendImage(image:UIImage){
        selectedImages.append(image)
        reloadData()
    }
//MARK: --delegate方法
    
    //当有加号item的时候点击让其添加照片
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        //加判断 只有最后有加号的时候才让其添加照片
        if indexPath.item == selectedImages.count{
           // print("添加照片")
            addPhotoClosure?()

        }
        
        
    }
    
    
}


//MARK: --自定义cell
class ZXAlbumCollectionViewCell: UICollectionViewCell {
    ///删除按钮的闭包
    var deleteCloure:(()->())?
    
    var selectImg:UIImage?{
        didSet{
           photoImg.image = selectImg
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.redColor()
        setUpUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpUI(){
        addSubview(photoImg)
        photoImg.frame = bounds
        addSubview(closeBtn)
        closeBtn.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(self.snp_top)
            make.right.equalTo(self.snp_right)
        }
    }
    
    lazy var photoImg:UIImageView = {
      let img = UIImageView()
      return img
    }()
    
    lazy var closeBtn:UIButton = {
       let btn = UIButton()
       btn.setImage(UIImage(named: "compose_photo_close"), forState: .Normal)
       btn.sizeToFit()
       btn.addTarget(self, action: "deleteImg", forControlEvents: .TouchUpInside)
       return btn
    }()
    
 //MARK: --删除按钮的点击事件
    func deleteImg(){
        deleteCloure?()
    }
    
    
}


