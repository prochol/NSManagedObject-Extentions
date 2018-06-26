//
// NSManagedObject+Request.swift
// NSManagedObject-Extentions
//
// Created by prochol on 6/26/18.
// Copyright © 2018. All rights reserved.
//

import Foundation
import CoreData

extension NSManagedObject {
    class func requestAll() -> NSFetchRequest<NSManagedObject> {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: self.entityName())
        return fetchRequest
    }

    class func requestAll(with predicate: NSPredicate) -> NSFetchRequest<NSManagedObject> {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: self.entityName())
        fetchRequest.predicate = predicate
        return fetchRequest
    }

    class func requestAll(sortedBy key: String, ascending: Bool = true) -> NSFetchRequest<NSManagedObject> {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: self.entityName())
        let sortDescriptor = NSSortDescriptor(key: key, ascending: ascending)
        fetchRequest.sortDescriptors = [sortDescriptor]
        return fetchRequest
    }

    class func requestAll(with predicate: NSPredicate, sortedBy key: String, ascending: Bool = true) -> NSFetchRequest<NSManagedObject> {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: self.entityName())
        fetchRequest.predicate = predicate
        let sortDescriptor = NSSortDescriptor(key: key, ascending: ascending)
        fetchRequest.sortDescriptors = [sortDescriptor]
        return fetchRequest
    }

    class func requestFirst() -> NSFetchRequest<NSManagedObject> {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: self.entityName())
        fetchRequest.fetchLimit = 1
        return fetchRequest
    }

    class func requestFirst(with predicate: NSPredicate) -> NSFetchRequest<NSManagedObject> {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: self.entityName())
        fetchRequest.predicate = predicate
        fetchRequest.fetchLimit = 1
        return fetchRequest
    }
}
