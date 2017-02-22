//
//  JCSerieMO.swift
//  Jobsity Challenge
//
//  Created by Camilo Medina on 22/02/17.
//  Copyright © 2017 Jobsity. All rights reserved.
//

import Foundation
import CoreData

class JCSerieMO: NSManagedObject {
	
	@NSManaged var id: String?
	@NSManaged var name: String?
	@NSManaged var language: String?
	@NSManaged var genres: String?
	@NSManaged var coverImgURL: String?
	@NSManaged var posterImgURL: String?
	@NSManaged var time: String?
	@NSManaged var days: String?
	@NSManaged var summary: String?
	
	
	static func saveSerieToLocalDatabase(_ serie: Serie) -> Bool {
		let dataController = CoreDataController()
	
		let serieEntity = NSEntityDescription.insertNewObject(forEntityName: "SerieEntity", into: dataController.managedObjectContext) as! JCSerieMO
		serieEntity.setValue(serie.id, forKey: "id")
		serieEntity.setValue(serie.name, forKey: "name")
		serieEntity.setValue(serie.language, forKey: "language")
		serieEntity.setValue(serie.genres.joined(separator: ","), forKey: "genres")
		serieEntity.setValue(serie.coverImgURL, forKey: "coverImgURL")
		serieEntity.setValue(serie.posterImgURL, forKey: "posterImgURL")
		serieEntity.setValue(serie.time, forKey: "time")
		serieEntity.setValue(serie.days.joined(separator: ","), forKey: "days")
		serieEntity.setValue(serie.summary, forKey: "summary")
		
		do {
			try dataController.managedObjectContext.save()
			print("Data saved successfully!")
		} catch let error as NSError  {
			print("Could not save \(error), \(error.userInfo)")
			return false
		}
		
		return true
	}
	
	static func loadSeriesFromLocalDatabase() -> [Serie]? {
		let moc = CoreDataController().managedObjectContext
		let seriesFetch: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "SerieEntity")
		let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
		let sortDescriptors = [sortDescriptor]
		seriesFetch.sortDescriptors = sortDescriptors
		seriesFetch.returnsObjectsAsFaults = false
		seriesFetch.entity = NSEntityDescription.entity(forEntityName: "SerieEntity", in: moc)
		
		do {
			let data = try moc.fetch(seriesFetch) as? [JCSerieMO]
			var seriesList: [Serie] = []
			
			for serieMO in data! {
				let id = serieMO.id!
				let name = serieMO.name!
				let language = serieMO.language!
				let genres = serieMO.genres!.components(separatedBy: ",")
				let coverImgURL = serieMO.coverImgURL
				let posterImgURL = serieMO.posterImgURL
				let time = serieMO.time!
				let days = serieMO.days!.components(separatedBy: ",")
				let summary = serieMO.summary!
				
				seriesList.append(Serie(id: id,
				                        name: name,
				                        language: language,
				                        genres: genres,
				                        coverImgURL: coverImgURL,
				                        posterImgURL: posterImgURL,
				                        time: time,
				                        days: days,
				                        summary: summary))
			}
	
			print("Data loaded successfully!")
			
			return seriesList
		} catch let error as NSError {
			print("Error \(error)")
			return nil
		}
	}
	
	static func findSerieInDatabase(withId id: String) -> Serie? {
		
		let managedObjects = getManagedObjects(withId: id)
		guard let serieMO = managedObjects else {
			return nil
		}
		
		guard serieMO.count > 0 else {
			return nil
		}
		
		let id = serieMO.first!.id!
		let name = serieMO.first!.name!
		let language = serieMO.first!.language!
		let genres = serieMO.first!.genres!.components(separatedBy: ",")
		let coverImgURL = serieMO.first!.coverImgURL
		let posterImgURL = serieMO.first!.posterImgURL
		let time = serieMO.first!.time!
		let days = serieMO.first!.days!.components(separatedBy: ",")
		let summary = serieMO.first!.summary!
		
		print("Data loaded successfully!")
		
		return Serie(id: id,
		             name: name,
		             language: language,
		             genres: genres,
		             coverImgURL: coverImgURL,
		             posterImgURL: posterImgURL,
		             time: time,
		             days: days,
		             summary: summary)
		
	}
	
	static  func getManagedObjects(withId id: String) -> [JCSerieMO]? {
		let moc = CoreDataController().managedObjectContext
		let seriesFetch: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "SerieEntity")
		let idPredicate = NSPredicate(format: "id = %@", id)
		seriesFetch.predicate = idPredicate
		seriesFetch.returnsObjectsAsFaults = false
		seriesFetch.entity = NSEntityDescription.entity(forEntityName: "SerieEntity", in: moc)
		
		do {
			return try moc.fetch(seriesFetch) as? [JCSerieMO]
		} catch {
			print(error)
			return nil
		}
	}
	
	static func removeSerieFromDatabase(withId id: String) {
		let moc = CoreDataController().managedObjectContext
		guard let seriesMO = getManagedObjects(withId: id) else {
			return
		}
		
		guard seriesMO.count > 0 else {
			return
		}
		
		moc.delete(seriesMO.first!)
		
		do {
			try moc.save()
		} catch let error as NSError {
			print("Detele data error : \(error) \(error.userInfo)")
		}
		
	}
	
}
