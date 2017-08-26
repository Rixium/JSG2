package Items 
{
	import flash.display.MovieClip;
	
	/**
	 * ...
	 * @author Rixium
	 */
	public class Item extends MovieClip 
	{
		
		public var itemType:int;
		public var displayName:String;
		public var description:String;
		public var forcePickup:Boolean;
		
		public function Item(image:int, type:int) 
		{
			super();
			gotoAndStop(image);
			itemType = type;
		}
		
	}

}