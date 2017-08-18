package Rooms 
{
	import flash.display.MovieClip;
	import Constants.GameManager;
	import Entity.EntityBase;
	import Objects.*;
	
	
	/**
	 * ...
	 * @author Rixium
	 */
	
	public class Room  extends MovieClip
	{
		
		protected var objects:Array;
		public var lastRoom:int
		protected var doors:Array;
		public var added:Boolean;
		
		protected var firstVisit:Boolean = true;
		
		public function Room() 
		{
			objects = [];
			doors = [];
		}
		
		public function Initialize():void {
			
			if(!added) {
				objects.push(getChildByName("leftCollide") as MovieClip);
				objects.push(getChildByName("topCollide") as MovieClip);
				objects.push(getChildByName("rightCollide") as MovieClip);
				objects.push(getChildByName("bottomCollide") as MovieClip);
			}
			
				var eLayer:MovieClip = getChildByName("entityLayer") as MovieClip;
				
				eLayer.addChild(GameManager.sean);
				eLayer = null;
		}
		
		public function AddObjects():void {
			
		}
		
		public function Clean():void {
			var bLayer:MovieClip = getChildByName("backgroundObjects") as MovieClip;
			var fLayer:MovieClip = getChildByName("foregroundObjects") as MovieClip;
			
			for (var i:int = 0; i < objects.length; i++) {
				var object:ObjectBase = objects[i];
				if (object.usable) {
					var useObject:UsableObject = objects[i];
					useObject.RemoveListeners(null);
					useObject = null;
				}
				object = null;
			}
			while (bLayer.numChildren > 0) {
				bLayer.removeChildAt(0);
			}
			while (fLayer.numChildren > 0) {
				fLayer.removeChildAt(0);
			}
		}
		
		public function CheckAble(e:EntityBase):Boolean {
			for(var i:int = 0; i < objects.length; i++) {
				
				if(objects[i].eBounds != null) {
					if(e.eBounds.hitTestObject(objects[i].eBounds)) {
						if(objects[i].collidable) {
							return false;
						}
					}
				} else if (e.eBounds.hitTestObject(objects[i])) {
					if(objects[i].collidable) {
						return false;
					}
				}
			}
			return true;
		}
		
	}

}