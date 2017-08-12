package Rooms 
{
	/**
	 * ...
	 * @author Rixium
	 */
	
	import Objects.*;
	import Constants.RoomNames;
	
	public class SeansRoom extends Room
	{
		
		public function SeansRoom() 
		{
			super();
		}
		
		public override function AddObjects():void {
			var bLayer:MovieClip = getChildByName("backgroundObjects") as MovieClip;
			var fLayer:MovieClip = getChildByName("foregroundObjects") as MovieClip;
			
			var studioLight:StudioLight = new StudioLight(588, 39, 106, 280);
			var cabinet:Chest = new Chest(700, 187, 120, 190);
			var desk:Table = new Table(920, 177, 313, 156);
			var shelf:Shelf = new Shelf(320, 19, 248, 302);
			var door:Door = new Door(165, 15, 125, 321, false, RoomNames.HALLWAY);
			var rug:Rug = new Rug(320, 380, 715, 267);
			var bed:Bed = new Bed(848, 531, 440, 220);
			
			var book:Book = new Book(955, 185, 52, 166);
			
			studioLight.displayName = "Studio Light";
			studioLight.description = "A professional light for exceptional quality.";
			studioLight.interactable = true;
			cabinet.displayName = "Cabinet";
			cabinet.description = "A place to store things.";
			cabinet.interactable = true;
			desk.displayName = "Desk";
			desk.description = "Not quite big enough.";
			desk.interactable = true;
			shelf.displayName = "Shelf";
			shelf.description = "A bunch of collectibles and fan stuff.";
			shelf.interactable = true;
			door.displayName = "To Hallway";
			door.description = "Covered in gross green slime.." + door.description;
			door.interactable = true;
			rug.displayName = "Rug";
			rug.description = "A luxurious red rug.";
			rug.collidable = false;
			bed.displayName = "Bed";
			bed.description = "A standard sized bed.";
			book.displayName = "Book";
			book.description = "Perhaps I should read that..";

			bLayer.addChild(studioLight);
			bLayer.addChild(cabinet);
			bLayer.addChild(desk);
			bLayer.addChild(shelf);
			bLayer.addChild(door);
			bLayer.addChild(rug);
			fLayer.addChild(bed);
			bLayer.addChild(book);
			
			objects.push(studioLight);
			objects.push(cabinet);
			objects.push(desk);
			objects.push(shelf);
			objects.push(door);
			objects.push(rug);
			objects.push(bed);
			objects.push(book);
		}
		
	}

}