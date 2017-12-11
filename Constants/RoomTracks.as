package Constants 
{
	import Sounds.AmbientHorror;
	import Sounds.BasementSound;
	import Sounds.MaFight;
	import Sounds.MaRoomAmbience;
	import Sounds.MaRoomShock;
	import Sounds.MainSound;
	import Sounds.SamFight;
	/**
	 * ...
	 * @author Rixium
	 */
	public class RoomTracks 
	{
		
		public static var MAIN = 1;
		public static var MAFIGHT = 2;
		public static var NONE = 3;
		public static var BASEMENT = 4;
		public static var MAROOMAMBIENCE = 5;
		public static var MAROOMSHOCK = 6;
		public static var SAMFIGHT = 7;
		public static var AMBIENTHORROR = 8;
		
		public static function GetMusic(track:int) {
			switch(track) {
				case MAIN:
					return new MainSound();
				case MAFIGHT:
					return new MaFight();
				case BASEMENT:
					return new BasementSound();
				case MAROOMAMBIENCE:
					return new MaRoomAmbience();
				case MAROOMSHOCK:
					return new MaRoomShock();
				case SAMFIGHT:
					return new SamFight();
				case AMBIENTHORROR:
					return new AmbientHorror();
				default:
					return null;
			}
		}
	}

}