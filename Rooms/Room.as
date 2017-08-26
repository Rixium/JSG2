package Rooms 
{
	import Entity.AbilityCosts;
	import Entity.Brazier;
	import Entity.EnemyBase;
	import flash.display.MovieClip;
	import Constants.GameManager;
	import Entity.EntityBase;
	import Objects.*;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.system.System;
	import Weapons.Weapon;
	
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
		protected var eLayer:MovieClip;
		public var canUpdate:Boolean = true;
		
		public function Room() 
		{
			canUpdate = true;
			objects = [];
			doors = [];
		}
		
		public function Initialize():void {
			canUpdate = true;
			GameManager.gameScreen.Follow(false);
			if(!added) {
				objects.push(getChildByName("leftCollide") as MovieClip);
				objects.push(getChildByName("topCollide") as MovieClip);
				objects.push(getChildByName("rightCollide") as MovieClip);
				objects.push(getChildByName("bottomCollide") as MovieClip);
			}
			
			eLayer = getChildByName("entityLayer") as MovieClip;
			
			eLayer.addChild(GameManager.sean);
		}
		
		public function AddObjects():void {
			
		}
		
		public function AttackEntities(e:EntityBase, weapon:Weapon) {
			for (var i:int = 0; i < eLayer.numChildren; i++) {
				var entity:EntityBase = eLayer.getChildAt(i) as EntityBase;
				
				var eRect:Rectangle = e.getBounds(stage);
				var entityRect:Rectangle = entity.getBounds(stage);
				
				if (weapon.hitbox.hitTestObject(entity)) {
					if (entity != weapon.holder) {
						var num:Number = Math.atan2((eRect.y + eRect.height) / 2 - (entityRect.y + entityRect.height) / 2, (eRect.x + eRect.width) / 2 - (entityRect.x + entityRect.width) / 2);
						entity.Hit(e, e.GetWeapon().power, e.GetWeapon().knockback, num);
					}
				}
			}
		}
		
		public function AddEnemies() { }
		
		public function AttackEntitiesNoWeapon(e:EntityBase, hitarea:MovieClip, damage:int, knockback:int ) {
			for (var i:int = 0; i < eLayer.numChildren; i++) {
				var entity:EntityBase = eLayer.getChildAt(i) as EntityBase;
				var eRect:Rectangle = e.eBounds.getBounds(stage);
				var entityRect:Rectangle = entity.getBounds(stage);
				if (e == entity) {
					continue;
				}
				
				if (hitarea.hitTestObject(entity.eBounds) || hitarea.contains(entity.eBounds)) {
					var num:Number = Math.atan2((eRect.y + eRect.height) / 2 - (entityRect.y + entityRect.height) / 2, (eRect.x + eRect.width) / 2 - (entityRect.x + entityRect.width) / 2);
					entity.Hit(e, damage, knockback, num);
				}
			}
		}
		
		public function Update():void {
			if(canUpdate) {
				if(eLayer.numChildren > 1) {
					for (var i:int = 0; i < eLayer.numChildren; i++) {
						if (i + 1 < eLayer.numChildren) {
							var e1:EntityBase = (eLayer.getChildAt(i) as EntityBase);
							var e2:EntityBase = eLayer.getChildAt(i + 1) as EntityBase;
							var rect1:Rectangle = e1.eBounds.getBounds(stage);
							var rect2:Rectangle = e2.eBounds.getBounds(stage);
							if (rect1.y + rect1.height > rect2.y + rect2.height) {
								eLayer.swapChildrenAt(i, i + 1);
							}
							rect1 = null;
							rect2 = null;
							e1 = null;
							e2 = null;
						}
					}
				}
				

				for (var z:int = 0; z < eLayer.numChildren; z++) {
					if(eLayer.getChildAt(z) != null) {
						var e:EntityBase = (eLayer.getChildAt(z)) as EntityBase;
						if(e != null) {
							e.Update();
						}
					}
				}
			}
		}
		
		public function AddEntity(e:EntityBase) {
			eLayer.addChild(e);
		}
		
		public function Clean():void {
			canUpdate = false;
			var bLayer:MovieClip = getChildByName("backgroundObjects") as MovieClip;
			var fLayer:MovieClip = getChildByName("foregroundObjects") as MovieClip;
			
			eLayer = null;
			
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
			
			bLayer = null;
			fLayer = null;
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
			
			for (var z:int = 0; z < eLayer.numChildren; z++) {
				var entity:EntityBase = eLayer.getChildAt(z) as EntityBase;
				if(e != entity) {
					if (e.eBounds.hitTestObject(entity.eBounds)) {
						return false;
					}
				}
				entity = null;
			}
			
			return true;
		}
		
	}

}