package Rooms 
{
	import Entity.AbilityCosts;
	import Entity.Brazier;
	import Entity.Bullet;
	import Entity.EnemyBase;
	import Entity.Explode;
	import Items.Drop;
	import fl.motion.easing.Exponential;
	import flash.display.MovieClip;
	import Constants.GameManager;
	import Entity.EntityBase;
	import Objects.*;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.system.System;
	import Weapons.Weapon;
	import Constants.RoomTracks;
	
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
		
		protected var drops:Array = [];
		protected var roomTrack:int = 0;
		public var lightMask;
		
		protected var shaking:Boolean = false;
		var startX:Number;
		var startY:Number;
		var goingLeft:Boolean = true;
		var goingRight:Boolean = false;
		
		public var frontLayer:MovieClip;
		
		var bullets:Array = [];
		
		var boss:EnemyBase;
		
		public function Room() 
		{
			canUpdate = true;
			objects = [];
			doors = [];
			GameManager.gameScreen.Follow(true);
			frontLayer = getChildByName("foregroundObjects") as MovieClip;
			roomTrack = RoomTracks.MAIN;
		}
		
		public function GetRightCollide():MovieClip {
				return getChildByName("rightCollide") as MovieClip;
		}
		
		public function GetLeftCollide():MovieClip {
				return getChildByName("leftCollide") as MovieClip;
		}
		
		public function Initialize():void {
			var lighter = getChildByName("lighter") as MovieClip;
			
			if (lighter != null) {
				lightMask = lighter;
				mask = lightMask;
				lighter = null;
				
				lightMask.mouseEnabled = false;
				lightMask.mouseChildren = false;
			}
			
			if(roomTrack != 0) {
				GameManager.gameScreen.musicManager.PlayTrack(roomTrack);
			}
			canUpdate = true;
			var bLayer:MovieClip = getChildByName("backgroundObjects") as MovieClip;
			
			if(!added) {
				objects.push(getChildByName("leftCollide") as MovieClip);
				objects.push(getChildByName("topCollide") as MovieClip);
				objects.push(getChildByName("rightCollide") as MovieClip);
				objects.push(getChildByName("bottomCollide") as MovieClip);
			}
			
			for (var i:int = 0; i < drops.length; i++) {
				var drop:Drop = drops[i] as Drop;
				bLayer.addChild(drop);
				drop.Initialize();
				drop.UseInitialize();
			}
			
			eLayer = getChildByName("entityLayer") as MovieClip;
			
			eLayer.addChild(GameManager.sean);
			
			bLayer = null;
		}
		
		public function AddDrop(drop:Drop) {
			var bLayer:MovieClip = getChildByName("backgroundObjects") as MovieClip;
			drop.dropNum = drops.length;
			drops.push(drop);
			bLayer.addChild(drop);
			bLayer = null;
		}
		
		public function RemoveDrop(drop:Drop) {
			drops.removeAt(drop.dropNum);
		}
		
		public function AddObjects():void {
			
		}
		
		public function SetBoss(e:EnemyBase) {
			this.boss = e;
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
						break;
					}
				}
			}
			if (boss != null) {
				if (e != boss) {
					if (weapon.hitbox.hitTestObject(boss.eBounds)) {
						boss.Hit(e, e.GetWeapon().power, e.GetWeapon().knockback, num);
					}
				}
			}
		}
		
		public function AddEnemies() { }
		
		public function AttackEntitiesNoWeapon(e:EntityBase, hitarea:MovieClip, damage:int, knockback:int ):Boolean {
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
					return true;
				}
			}
			
			if (boss != null) {
				if (e != boss) {
					if(hitarea.hitTestObject(boss.eBounds)) {
						boss.Hit(e, damage, knockback, num);
					}
				}
			}
			return false;
		}
		
		public function BulletAttack(e:EntityBase, hitarea:MovieClip, damage:int, knockback:int):Boolean {
			for (var i:int = 0; i < eLayer.numChildren; i++) {
				var entity:EntityBase = eLayer.getChildAt(i) as EntityBase;
				var eRect:Rectangle = e.eBounds.getBounds(stage);
				var entityRect:Rectangle = entity.getBounds(stage);
				if (e == entity) {
					continue;
				}
				
				if (hitarea.hitTestObject(entity.GetHitBounds()) && !entity.immune) {
					var num:Number = Math.atan2((eRect.y + eRect.height) / 2 - (entityRect.y + entityRect.height) / 2, (eRect.x + eRect.width) / 2 - (entityRect.x + entityRect.width) / 2);
					entity.Hit(e, damage, knockback, num);
					return true;
				}
			}
			
			if (boss != null) {
				if (e != boss) {
					if (hitarea.hitTestObject(boss.GetHitBounds()) && !boss.immune) {
						boss.Hit(e, damage, knockback, num);
						return true;
					}
				}
			}
			return false;
		}
			
		public function DamageEntities(hitarea:MovieClip, damage:int, knockback:int ):Boolean {
			for (var i:int = 0; i < eLayer.numChildren; i++) {
				var entity:EntityBase = eLayer.getChildAt(i) as EntityBase;
				if (hitarea.hitTestObject(entity) || hitarea.contains(entity)) {
					entity.Hit(null, damage, 0, 0);
					return true;
				}
			}
			return false;
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
				
				for (var y:int = 0; y < bullets.length; y++) {
					var bullet:Bullet = bullets[y] as Bullet;
					bullet.Update();
					if (BulletAttack(bullet.GetOwner(), bullet, bullet.GetDamage(), bullet.GetKnockback())) {
						bullet.SetDead();
						var explode:Explode = new Explode(bullet.getBounds(GameManager.gameScreen.roomLayer).x, bullet.getBounds(GameManager.gameScreen.roomLayer).y);
						addChild(explode);
						explode = null;
					}
					if (bullet.GetDead()) {
						bullets.removeAt(y);
						bullet.Kill();
						break;
					}
					
					bullet = null;
				}
			}
		}
		
		public function AddEntity(e:EntityBase) {
			eLayer.addChild(e);
		}
		
		public function AddBackItem(e:ObjectBase) {
			var bLayer:MovieClip = getChildByName("backgroundObjects") as MovieClip;
			bLayer.addChild(e);
			bLayer = null;
		}
		
		public function AddBullet(b:Bullet) {
			bullets.push(b);
			addChild(b);
		}
		public function Clean():void {
			canUpdate = false;
			var bLayer:MovieClip = getChildByName("backgroundObjects") as MovieClip;
			var fLayer:MovieClip = frontLayer;
			
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
		
		public function CheckAble(e:EntityBase, ignoreEntities:Boolean):Boolean {
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
			
			if(!ignoreEntities) {
				for (var z:int = 0; z < eLayer.numChildren; z++) {
					var entity:EntityBase = eLayer.getChildAt(z) as EntityBase;
					if(e != entity) {
						if (e.eBounds.hitTestObject(entity.eBounds)) {
							return false;
						}
					}
					entity = null;
				}
			}
			return true;
		}
		
		public function Shake() {
			if (!shaking) {
				goingLeft = true;
				startX = this.x;
				startY = this.y;
			}
			
			shaking = true;
			if (this.x > startX - 2 && goingLeft) {
				x -= 2;
			} else if (this.x < startX + 2 && goingRight) {
				x += 2;
			}
			
			if (this.x <= startX - 2) {
				goingLeft = false;
				goingRight = true;
			} else if (this.x >= startX + 2) {
				goingLeft = true;
				goingRight = false;
			}
		}
		
		public function StopShake() {
			shaking = false;
			this.x = startX;
			this.y = startY;
		}
		
	}

}