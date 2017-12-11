package Constants
{
	import flash.utils.Dictionary;
	import flash.utils.describeType;
	import flash.ui.Keyboard;
	
	public class Keys
	{
		
		public static var LEFT = 65;
		public static var RIGHT = 68;
		public static var UP = 87;
		public static var DOWN = 83;
		public static var SPRINT = 16;
		public static var USE = 69;
		public static var INVENTORY = 73;
		public static var ROLL = 32;
		public static var EQUIP = 81;
		public static var BAG = 66;
		public static var PAUSE = 80;

		public static var KeyToChar:Array = new Array("null", "1",  "2", "3", "4", "5", "6", "7", "Backspace", "Tab", "10", "11", "12", "Enter", "14", "15", "Shift", "Ctrl", 
		"Alt", "Break", "Caps Lock", "21", "22", "23", "24", "25", "26", "Esc", "28", "29", "30", "31", "Space", "Page Up", "Page Down", "End", "Home", 
		"Left", "Up", "Right", "Down", "41", "42", "43", "Print Screen", "Insert", "Delete", "47", "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", ":", ";", 
		"60", "=", "62", "63", "64", "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", 
		"Y", "Z", "91", "92", "93", "94", "95", "N0", "N1", "N2", "N3", "N4", "N5", "N6", "N7", "N8", "N9", "Numpad-Multiply", 
		"Numpad-Plus", "k", "Numpad-Minus", "Numpad-Decimal", "Numpad-Divide", "F1", "F2", "F3", "F4", "F5", "F6", "F7", "F8", "F9", "F10", "F11", "F12", "124", "125", "~", "127", "128", "129", "130", "131", 
		"132", "133", "134", "135", "136", "137", "138", "139", "140", "141", "142", "143", "Num Lock", "Scroll Lock", "146", "147", "148", "149", "150", "151", "152", "153", "154", "155", "156", "157", "158", "159", "160", 
		"161", "162", "163", "164", "165", "166", "167", "168", "169", "170", "171", "172", "173", "174", "175", "176", "177", "178", "179", "180", "181", "182", "183", "184", "185", ";", "=", ",", "-", ".", "/", "`", "193", 
		"194", "195", "196", "197", "198", "199", "200", "201", "202", "203", "204", "205", "206", "207", "208", "209", "210", "211", "212", "213", "214", "215", "216", "217", "218", "[", "\\", "]", "\"", "223", "224", "225", "226", 
		"227", "228", "229", "230", "231", "232", "233", "234", "235", "236", "237", "238", "239", "240", "241", "242", "243", "244", "245", "246", "247", "248", "249", "250", "251", "252", "253", "254", "255");

		public static var slots:Array = new Array( 49, 50, 51, 52, 53, 54, 55, 56, 57 );
		
		public static function GetDictionary():Dictionary {
			var keyDescription:XML = describeType(Keyboard);
			var keyNames:XMLList = keyDescription..constant.@name;

			var keyboardDict:Dictionary = new Dictionary();

			var len:int = keyNames.length();
			for(var i:int = 0; i < len; i++) {
				keyboardDict[Keyboard[keyNames[i]]] = keyNames[i];
			}

			return keyboardDict;
		}
		
	}
}