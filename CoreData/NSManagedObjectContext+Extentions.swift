//
// NSManagedObjectContext+Extentions.swift
// NSManagedObject-Extentions
//
// Created by prochol on 19.04.17.
// Copyright © 2018. All rights reserved.
//

import CoreData

extension NSManagedObjectContext {
    //To recover from the URL when switching from Spotlight
    //Taken from court: http://stackoverflow.com/questions/30028636/core-data-get-managed-object-by-uri
    func getManagedObject(withURI uri: URL) -> NSManagedObject? {
        if let psc = persistentStoreCoordinator {
            if let objectID = psc.managedObjectID(forURIRepresentation: uri) {

                let object: NSManagedObject = self.object(with: objectID)

                if !object.isFault {
                    return object
                }

                let predicate = NSComparisonPredicate(leftExpression: .expressionForEvaluatedObject(),
                        rightExpression: NSExpression(forConstantValue: object),
                        modifier: .direct,
                        type: .equalTo,
                        options: .caseInsensitive)

                let request = NSFetchRequest<NSFetchRequestResult>()
                request.entity = objectID.entity
                request.predicate = predicate

                let results: [NSManagedObject] = try! self.fetch(request) as! [NSManagedObject]

                if !results.isEmpty {
                    return results.first
                }
            }
        }

        return nil;
    }

    class func `default`() -> NSManagedObjectContext {
//        return AFLSingletonManager.sharedManager.coreDataManager.managedObjectContext
        return self.mr_default()
    }

    class func newMainQueue() -> NSManagedObjectContext {
        let managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext.parent = self.default()
        return managedObjectContext
    }
}
