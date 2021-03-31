//
//  CommentsObject.swift
//  Thapovan
//
//  Created by E5000416 on 30/03/21.
//

import Foundation
class CommentObject{
    var comment:String?
    var replies:[String] = []
    var isOpen = false
    init(dict:NSDictionary) {
        self.comment = dict["comment"] as? String
        for reply in (dict["replies"] as? [String] ?? []) {
            self.replies.append(reply)
        }
    }
}


