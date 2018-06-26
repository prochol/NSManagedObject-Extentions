//
// NSManagedObject+Find.swift
// NSManagedObject-Extentions
//
// Created by prochol on 6/26/18.
// Copyright © 2018. All rights reserved.
//

import Foundation
import CoreData

extension NSManagedObject {
    // MARK: find All

    class func findAll(in context: NSManagedObjectContext = NSManagedObjectContext.default()) -> [NSManagedObject]? {
        let fetchRequest = self.requestAll()
        return self.execute(fetchRequest: fetchRequest, in: context)
    }

    class func findAll(with predicate: NSPredicate, in context: NSManagedObjectContext = NSManagedObjectContext.default()) -> [NSManagedObject]? {
        let fetchRequest = self.requestAll(with: predicate)
        return self.execute(fetchRequest: fetchRequest, in: context)
    }

    class func findAll(sortedBy key: String, ascending: Bool = true, in context: NSManagedObjectContext = NSManagedObjectContext.default()) -> [NSManagedObject]? {
        let fetchRequest = self.requestAll(sortedBy: key, ascending: ascending)
        return self.execute(fetchRequest: fetchRequest, in: context)
    }

    class func findAll(with predicate: NSPredicate, sortedBy key: String, ascending: Bool = true, in context: NSManagedObjectContext = NSManagedObjectContext.default()) -> [NSManagedObject]? {
        let fetchRequest = self.requestAll(with: predicate, sortedBy: key, ascending: ascending)
        return self.execute(fetchRequest: fetchRequest, in: context)
    }

    // MARK: find One

    class func findFirst(in context: NSManagedObjectContext = NSManagedObjectContext.default()) -> NSManagedObject? {
        let fetchRequest = self.requestFirst()
        if let result = self.execute(fetchRequest: fetchRequest, in: context)?.first {
            return result
        }
        return nil
    }

    class func findFirst(with predicate: NSPredicate, in context: NSManagedObjectContext = NSManagedObjectContext.default()) -> NSManagedObject? {
        let fetchRequest = self.requestFirst(with: predicate)
        if let result = self.execute(fetchRequest: fetchRequest, in: context)?.first {
            return result
        }
        return nil
    }

    // MARK: execute

    private class func execute(fetchRequest: NSFetchRequest<NSManagedObject>, in context: NSManagedObjectContext = NSManagedObjectContext.default()) -> [NSManagedObject]? {
        do {
            return try (context.fetch(fetchRequest) as? [NSManagedObject])
        }
        catch let error {
            debugPrint("The fetch request executed FAILED with error: \(error)")
            return nil
        }
    }
}
