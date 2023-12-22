//
//  MyPost.swift
//  Storage Service
//
//  Created by Денис Штоколов on 12.12.2023.
//

import Foundation

public struct MyPost {
    public var authorLabel: String
    public var avatar: Data
    public var photo: Data
    public var postText: String
    
    public init(authorLabel: String, avatar: Data, photo: Data, postText: String) {
        self.authorLabel = authorLabel
        self.avatar = avatar
        self.photo = photo
        self.postText = postText
    }
}
public var myPosts = [MyPost]()
