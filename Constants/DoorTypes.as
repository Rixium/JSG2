package Constants 
{
	import Sounds.CloseBookSound;
	import Sounds.DoorCloseSound;
	import Sounds.GateSound;
	import Sounds.LadderSound;
	import Sounds.SpecialDoorSound;
	import Sounds.StairsSound;
	/**
	 * ...
	 * @author Rixium
	 */
	public class DoorTypes 
	{
		
		public static var CLEAN = 1;
		public static var SLIME = 2;
		public static var ARROW = 3;
		public static var HATCHBOTTOM = 4;
		public static var HATCHTOP = 5;
		public static var SIDE = 6;
		public static var STAIRSHALL = 7;
		public static var STAIRDOOR = 8;
		public static var STAIRSUP = 9;
		public static var SHEDDOOR = 10;
		public static var SPECIALDOOR = 11;
		public static var GARDENGATE = 12;
		
		public static function GetSound(doorType:int) {
			switch(doorType) {
				
				case CLEAN:
				case SLIME:
				case ARROW:
				case SIDE:
				case SHEDDOOR:
					return new DoorCloseSound();
				case HATCHBOTTOM:
				case HATCHTOP:
					return new StairsSound();
				case STAIRSHALL:
				case STAIRSUP:
					return new StairsSound();
				case SPECIALDOOR:
					return new SpecialDoorSound();
				case GARDENGATE:
					return new GateSound();
				default:
					return null;
			}
		}
		
	}

}