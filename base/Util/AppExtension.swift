//
//  AppExtension.swift
//  base
//
//  Created by Desarrollo on 4/15/19.
//  Copyright © 2019 Desarrollo. All rights reserved.
//

import Foundation
import UIKit

public enum ImageFormat {
    case PNG
    case JPEG(CGFloat)
}

extension UIImage {
    
    /// Convert strint o base64
    ///
    /// - Parameter format: ImageFormat
    /// - Returns: String
    public func base64(_ format: ImageFormat) -> String? {
        var imageData: Data?
        switch format {
        case .PNG: imageData = self.pngData()
        case .JPEG(let compression): imageData = self.jpegData(compressionQuality: compression)
        }
        return imageData?.base64EncodedString()
    }
    
    /// Change color icon
    ///
    /// - Parameter color: UIColor
    /// - Returns: UIImage
    func tint(_ color: UIColor) -> UIImage{
        UIGraphicsBeginImageContext(self.size)
        guard let context = UIGraphicsGetCurrentContext() else { return self }
        
        context.scaleBy(x: 1.0, y: -1.0)
        context.translateBy(x: 0.0, y: -self.size.height)
        
        context.setBlendMode(.multiply)
        
        let rect = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height)
        context.clip(to: rect, mask: self.cgImage!)
        color.setFill()
        context.fill(rect)
        
        guard let newImage = UIGraphicsGetImageFromCurrentImageContext() else { return self }
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
    /// Resize image
    ///
    /// - Returns: UIImage
    func resize() -> UIImage{
        var actualHeight:Float = Float(self.size.height)
        var actualWidth:Float = Float(self.size.width)
        
        let maxHeight:Float = 180.0
        let maxWidth:Float = 180.0
        
        var imgRatio:Float = actualWidth/actualHeight
        let maxRatio:Float = maxWidth/maxHeight
        
        if (actualHeight > maxHeight) || (actualWidth > maxWidth)
        {
            if(imgRatio < maxRatio)
            {
                imgRatio = maxHeight / actualHeight;
                actualWidth = imgRatio * actualWidth;
                actualHeight = maxHeight;
            }
            else if(imgRatio > maxRatio)
            {
                imgRatio = maxWidth / actualWidth;
                actualHeight = imgRatio * actualHeight;
                actualWidth = maxWidth;
            }
            else
            {
                actualHeight = maxHeight;
                actualWidth = maxWidth;
            }
        }
        
        let rect:CGRect = CGRect(x: 0.0, y: 0.0, width: CGFloat(actualWidth), height: CGFloat(actualHeight))
        UIGraphicsBeginImageContext(rect.size)
        self.draw(in: rect)
        
        let img:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        let imageData:NSData = img.jpegData(compressionQuality: 1.0)! as NSData
        UIGraphicsEndImageContext()
        
        return UIImage(data: imageData as Data)!
    }
    
    func imageWithImage(_ newSize:CGSize) -> UIImage{
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0);
        self.draw(in: CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: newSize.width, height: newSize.height))  )
        let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
    }
    
}

extension URL {
    func appendingUniquePathComponent(_ pathExtension: String? = nil) -> URL {
        var pathComponent = UUID().uuidString
        if let pathExtension = pathExtension {
            pathComponent += ".\(pathExtension)"
        }
        return appendingPathComponent(pathComponent)
    }
}

extension Date {
    
    var current: Date {
        return Date()
    }
    
    /// Format date to string date
    ///
    /// - Parameters: format: String old date format
    /// - Returns: String
    func format(_ format: String) ->String{
        let formatter = DateFormatter()
        
        let dateString = formatter.string(from: self)
        let date = formatter.date(from: dateString)
        formatter.dateFormat = format
        
        return formatter.string(from: date!)
    }
    
    var ticks: UInt64 {
        return UInt64((self.timeIntervalSince1970 + 62_135_596_800) * 10_000_000)
    }
    
}

extension UITextField {
    
    /// Custom border field text
    func border(){
        self.layer.borderColor = AppColor.hex("#6A7D8E").cgColor
        self.layer.borderWidth = 1.5
        self.layer.cornerRadius = 5
    }
    
}

extension Double {

    var asLocaleCurrency:String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = NSLocale(localeIdentifier: "es_GT") as Locale?
        return formatter.string(from: NSNumber(value: self))!
    }
    
    var asUsdCurrency:String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = NSLocale(localeIdentifier: "en_US") as Locale?
        return formatter.string(from: NSNumber(value: self))!
    }
    
    /// Format milliseconds to string date
    ///
    /// - Parameter format: String
    /// - Returns: String
    func milliToString(_ format: String) ->String {
        let date = Date(timeIntervalSince1970: (self / 1000.0))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        
        return dateFormatter.string(from: date)
    }
    
}

public extension UIDevice {
    
    enum `Type` {
        case iPad
        case iPhone_unknown
        case iPhone_5_5S_5C
        case iPhone_6_6S_7_8
        case iPhone_6_6S_7_8_PLUS
        case iPhone_X_Xs
        case iPhone_Xs_Max
        case iPhone_Xr
    }
    
    var hasHomeButton: Bool {
        switch type {
        case .iPhone_X_Xs, .iPhone_Xr, .iPhone_Xs_Max:
            return false
        default:
            return true
        }
    }
    
    var type: Type {
        if userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
            case 1136:
                return .iPhone_5_5S_5C
            case 1334:
                return .iPhone_6_6S_7_8
            case 1920, 2208:
                return .iPhone_6_6S_7_8_PLUS
            case 2436:
                return .iPhone_X_Xs
            case 2688:
                return .iPhone_Xs_Max
            case 1792:
                return .iPhone_Xr
            default:
                return .iPhone_unknown
            }
        }
        
        return .iPad
    }
}

extension String {
    
    /// Parse string to date
    ///
    /// - Parameters:
    ///   - oldFormat: String
    ///   - newFormat: String
    /// - Returns: Date
    func format(_ oldFormat: String, newFormat: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = oldFormat
        dateFormatter.locale = NSLocale(localeIdentifier: "es_GT") as Locale?
        let tempDate = dateFormatter.date(from: self)!
        
        let formatter = DateFormatter()
        formatter.dateFormat = newFormat
        formatter.locale = NSLocale(localeIdentifier: "es_GT") as Locale?
        let stringDate = formatter.string(from: tempDate)
        
        return formatter.date(from: stringDate)!
    }
    
    var validEmail: Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: self)
    }
    
    var validNit: Bool {
        return self.range(of:"-") != nil
    }
    
}

extension UIViewController: UITextFieldDelegate, UITextViewDelegate{
    
    /// Add toolbar to TextField
    ///
    /// - Parameter textField:  UITextField
    func addToolBar(_ textField: UITextField){
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.backgroundColor = UIColor.white
        let doneButton = UIBarButtonItem(image: #imageLiteral(resourceName: "ic_hide_keyboard").imageWithImage(CGSize(width: 30.0, height: 30.0)), style: UIBarButtonItem.Style.done, target: self, action: #selector(UIViewController.donePressed))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        toolBar.setItems([spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        toolBar.sizeToFit()
        
        textField.delegate = self
        textField.inputAccessoryView = toolBar
    }
    
    /// Add choose to TextField
    ///
    /// - Parameters:
    ///   - textField: UITextField
    ///   - picker: UIPickerView
    func addChoose(_ textField: UITextField, picker: UIPickerView){
        picker.showsSelectionIndicator = true
        
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(image: #imageLiteral(resourceName: "ic_hide_keyboard").imageWithImage(CGSize(width: 30.0, height: 30.0)), style: UIBarButtonItem.Style.plain, target: self, action: #selector(UIViewController.donePressed))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        
        toolBar.setItems([spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        textField.inputView = picker
        textField.inputAccessoryView = toolBar
    }
    
    /// Add toolbar to TextView
    ///
    /// - Parameter textView: UITextView
    func addToolBarTextView(_ textView: UITextView){
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        
        let doneButton = UIBarButtonItem(image: #imageLiteral(resourceName: "ic_hide_keyboard").imageWithImage(CGSize(width: 30.0, height: 30.0)), style: UIBarButtonItem.Style.plain, target: self, action: #selector(UIViewController.donePressed))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        toolBar.setItems([spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        toolBar.sizeToFit()
        
        textView.delegate = self
        textView.inputAccessoryView = toolBar
    }
    
    /// Add image left to TextField
    ///
    /// - Parameters:
    ///   - textField: UITextField
    ///   - image: UIImage
    func imageLeft(_ textField: UITextField, image: UIImage){
        let imageView = UIImageView()
        imageView.image = image
        
        let leftView = UIView()
        leftView.addSubview(imageView)
        
        leftView.frame = CGRect(x: 0, y: 0, width: 35, height: 25)
        imageView.frame =  CGRect(x: 10, y: 0, width: 20, height: 20)
        
        textField.leftView = leftView
        textField.leftViewMode = UITextField.ViewMode.always
    }
    
    /// Add image rigth to TextField
    ///
    /// - Parameters:
    ///   - textField: UITextField
    ///   - image: UIImage
    func imageRigth(_ textField: UITextField, image: UIImage){
        let imageView = UIImageView()
        imageView.image = image
        
        let rigthView = UIView()
        rigthView.addSubview(imageView)
        
        rigthView.frame = CGRect(x: 0, y: 0, width: 35, height: 15)
        imageView.frame = CGRect(x: 10, y: 0, width: 15, height: 15)
        
        textField.rightView = rigthView
        textField.rightViewMode = UITextField.ViewMode.always
    }
    
    /// Add image rigth to TextField
    ///
    /// - Parameters:
    ///   - textField: UITextField
    ///   - image: UIImage
    func imageRigthChoose(_ textField: UITextField, image: UIImage){
        let imageView = UIImageView()
        imageView.image = image
        
        let rigthView = UIView()
        rigthView.addSubview(imageView)
        
        rigthView.frame = CGRect(x: 0, y: 0, width: 35, height: 10)
        imageView.frame = CGRect(x: 10, y: 0, width: 10, height: 10)
        
        textField.rightView = rigthView
        textField.rightViewMode = UITextField.ViewMode.always
    }
    
    /// Done choose
    @objc func donePressed(){
        view.endEditing(true)
    }
    
    /// Cancel choose
    func cancelPressed(){
        view.endEditing(true)
    }
    
    /// Add border to TextField
    ///
    /// - Parameter textField: UITextField
    func addBorderTextField(_ textField: UITextField){
        let border = CALayer()
        let width = CGFloat(0.5)
        border.borderColor = UIColor.darkGray.cgColor
        border.frame = CGRect(x: 0, y: textField.frame.size.height - width, width:  textField.frame.size.width, height: textField.frame.size.height)
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 15))
        textField.leftView = paddingView
        textField.leftViewMode = UITextField.ViewMode.always
        textField.layer.cornerRadius = 4
        
        border.borderWidth = width
    }
    
    /// Add padding left to TextField
    ///
    /// - Parameter textField: UITextField
    func addPaddingLeft(_ textField: UITextField){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: 8))
        textField.leftView = paddingView
        textField.leftViewMode = UITextField.ViewMode.always
        textField.layer.cornerRadius = 4
    }
    
    /// Add DatePicker to TextField
    ///
    /// - Parameter textField: AppFieldText
    func addDatePicker(_ textField: AppFieldText){
        let picker: AppDatePicker = AppDatePicker()
        picker.datePickerMode = .date
        picker.timeZone = NSTimeZone.local
        picker.locale = Locale.init(identifier: "es_ES")
        picker.backgroundColor = UIColor.white
        picker.layer.cornerRadius = 5.0
        picker.layer.shadowOpacity = 0.5
        picker.textField = textField
        
        picker.addTarget(self, action: #selector(onDidChangeDate(sender:)), for: .valueChanged)
        textField.addTarget(self, action: #selector(onDidChangeField(sender:)), for: .editingDidBegin)
        
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(image: #imageLiteral(resourceName: "ic_hide_keyboard").imageWithImage(CGSize(width: 30.0, height: 30.0)), style: UIBarButtonItem.Style.plain, target: self, action: #selector(UIViewController.donePressed))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        
        toolBar.setItems([spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        textField.inputView = picker
        textField.inputAccessoryView = toolBar
    }
    
    /// Format and set date
    ///
    /// - Parameter sender: AppDatePicker
    @objc internal func onDidChangeDate(sender: AppDatePicker){
        // date format
        let dateFormat: DateFormatter = DateFormatter()
        dateFormat.dateFormat = "dd/MM/yyyy"
        dateFormat.timeZone = TimeZone.current
        dateFormat.locale = NSLocale(localeIdentifier: "es_GT") as Locale?
        
        sender.textField?.text = dateFormat.string(from: sender.date)
        sender.textField?.timeStamp = UInt64(sender.date.timeIntervalSince1970 * 1000)
    }
    
    /// Format and set date default
    ///
    /// - Parameter sender: AppFieldText
    @objc internal func onDidChangeField(sender: AppFieldText){
        // date format
        let dateFormat: DateFormatter = DateFormatter()
        dateFormat.dateFormat = "dd/MM/yyyy"
        dateFormat.timeZone = TimeZone.current
        dateFormat.locale = NSLocale(localeIdentifier: "es_GT") as Locale?
        
        sender.text = dateFormat.string(from: Date())
        sender.timeStamp = UInt64(Date().timeIntervalSince1970 * 1000)
    }
    
}
