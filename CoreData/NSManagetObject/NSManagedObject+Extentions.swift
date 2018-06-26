//
// NSManagedObject+Extentions.swift
// NSManagedObject-Extentions
//
// Created by prochol on 6/22/18.
// Copyright © 2018. All rights reserved.
//

import Foundation
import CoreData

extension NSManagedObject {
    @objc(inContext:)
    func `in`(context context: NSManagedObjectContext) -> Self? {
        return self.object(inContext: context)
    }

    private func object<T: NSManagedObject>(inContext context: NSManagedObjectContext) -> T? {
        if self.objectID.isTemporaryID {
            do {
                try self.managedObjectContext?.obtainPermanentIDs(for:[self])
            }
            catch let error {
                debugPrint("ManagedObject in context FAILED with error: \(error)")
                return nil
            }
        }

        do {
            return try (context.existingObject(with: self.objectID) as? T)
        }
        catch let error {
            debugPrint("ManagedObject in context FAILED with error: \(error)")
            return nil
        }
    }

    class func entityName() -> String {
        if #available(iOS 10.0, *) {
            if let entityName = self.entity().name {
                return entityName
            }
            else {
                return String(describing: self)
            }
        }
        return String(describing: self)
    }
}
