package Rooms 
{
	/**
	 * ...
	 * @author Rixium
	 */
	
	import Objects.*;
	import Constants.*;
	import Items.*;
	import Weapons.Weapon;
	
	public class SeansRoom extends Room
	{
		
		var studioLight:StudioLight;
		var cabinet:Chest;
		var desk:Table;
		var shelf:Shelf;
		var door:Door;
		var rug:Rug;
		var bed:Bed;
		var computerScreen:ComputerScreen;
		var book:Book;
		var computerTower:ComputerTower;
		var plant:Plant;
		var camera:Cam;
		
		public function SeansRoom(lastRoom:int) 
		{
			super();
			this.lastRoom = lastRoom;
		}
		
		public override function AddObjects():void {
			var bLayer:MovieClip = getChildByName("backgroundObjects") as MovieClip;
			var fLayer:MovieClip = getChildByName("foregroundObjects") as MovieClip;
			
			if(studioLight == null) {
				studioLight = new StudioLight(588, 88, 106, 280);
				studioLight.displayName = "Studio Light";
				studioLight.description = "A professional light for exceptional quality.";
				studioLight.interactable = true;
				objects.push(studioLight);
			}
			
			if(cabinet == null) {
				cabinet = new Chest(700, 226, 120, 190);
				cabinet.displayName = "Cabinet";
				cabinet.description = "A place to store things.";
				cabinet.interactable = true;
				objects.push(cabinet);

				var key:DoorKey = new DoorKey(RoomNames.HALLWAY, ItemImages.STANDARDKEY);
				key.displayName = "Spare Key";
				key.description = "A copy of the key for Sean's Door.";
				cabinet.SetItem(key);
				key = null;
			}
			
			
			
			if(desk == null) {
				desk = new Table(820, 223, 313, 156);
				desk.displayName = "Desk";
				desk.description = "Not quite big enough.";
				desk.interactable = true;
				objects.push(desk);
			}
			if(shelf == null) {
				shelf = new Shelf(320, 64, 248, 302);
				shelf.displayName = "Shelf";
				shelf.description = "A bunch of collectibles and fan stuff.";
				shelf.interactable = true;
				objects.push(shelf);
			}
			if(door == null) {
				door = new Door(120, 61, 125, 312, true, RoomNames.HALLWAY, RoomNames.SEANSROOM, DoorTypes.SLIME);
				door.displayName = "Door";
				door.description = "Covered in gross green slime..";
				door.interactable = true;
				objects.push(door);
				doors.push(door);
			}
			if(rug == null) {
				rug = new Rug(320, 380, 715, 267);
				rug.displayName = "Rug";
				rug.description = "A luxurious red rug.";
				rug.collidable = false;
				objects.push(rug);
			}
			if(bed == null) {
				bed = new Bed(848, 540, 440, 220);
				bed.displayName = "Bed";
				bed.description = "A standard sized bed.";
				objects.push(bed);
			}
			if(computerScreen == null) {
				computerScreen = new ComputerScreen(905, 139, 140, 130);
				computerScreen.displayName = "Monitor";
				computerScreen.description = "There is a hole in the screen..";
				objects.push(computerScreen);
			}
			if(book == null) {
				book = new Book(1055, 232, 52, 166);
				book.displayName = "Book";
				book.description = "Perhaps I should read that..";
				objects.push(book);
			}
			
			if (computerTower == null) {
				computerTower = new ComputerTower(1143, 274, 69, 91);
				computerTower.displayName = "Tower";
				computerTower.description = "A dashing white case with plenty of space inside.";
				objects.push(computerTower);
			}
			
			if (plant == null) {
				plant = new Plant(14, 550, 190, 203);
				plant.displayName = "Plant";
				plant.description = "It's green, and leafy.";
				objects.push(plant);
			}
			
			if (camera == null) {
				camera = new Cam(834, 129, 84, 119);
				camera.displayName = "Camera";
				camera.description = "One of the best Cameras for Youtube Video."
				objects.push(camera);
			}
			
			bLayer.addChild(studioLight);
			bLayer.addChild(cabinet);
			bLayer.addChild(desk);
			bLayer.addChild(shelf);
			bLayer.addChild(door);
			bLayer.addChild(rug);
			fLayer.addChild(bed);
			bLayer.addChild(book);
			bLayer.addChild(computerScreen);
			bLayer.addChild(computerTower);
			bLayer.addChild(camera);
			fLayer.addChild(plant);
			
			studioLight.Initialize();
			cabinet.Initialize();
			cabinet.UseInitialize();
			desk.Initialize();
			shelf.Initialize();
			door.Initialize();
			door.UseInitialize();
			rug.Initialize();
			bed.Initialize();
			book.Initialize();
			book.UseInitialize();
			computerScreen.Initialize();
			computerTower.Initialize();
			plant.Initialize();
			camera.Initialize();
			
			if (lastRoom != RoomNames.NONE) {
				for (var i:int = 0; i < doors.length; i++) {
					var d:Door = doors[i];
					if (d.roomLink == lastRoom) {
						GameManager.sean.x = d.x + d.width / 2;
						GameManager.sean.y = d.y + d.height / 2 + 20;
					}
					d = null;
				}
				
			}
			
			bLayer = null;
			fLayer = null;
			
		}
		
	}

}