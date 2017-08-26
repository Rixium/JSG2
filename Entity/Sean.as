package Entity
{
	
	import Chat.ChatLine;
	import Chat.Conversation;
	import Chat.Phone;
	import Items.DoorKey;
	import Items.Item;
	import Items.WeaponItem;
	import Objects.Door;
	import Rooms.MasRoom;
	import Sounds.SlashFour;
	import Sounds.SlashOne;
	import Sounds.SlashThree;
	import Sounds.SlashTwo;
	import Weapons.Weapon;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.media.Sound;
	import flash.text.TextField;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import Sounds.*;
	
	import Constants.*;
	
	import Screens.GameScreen;
	import Screens.Screen;
	
	public class Sean extends EntityBase
	{
		
		var moveLeft:Boolean;
		var moveUp:Boolean;
		var moveDown:Boolean;
		var moveRight:Boolean;
		var sprint:Boolean;
		
		var gameScreen:GameScreen;
		
		var sprintResetTimer:int = 0;
		var sprintResetMaxTime:int = 20;

		var inventory:Inventory;

		var currentItem:Item;
		
		public var phone:Phone;
		
		private var iKeyUp:Boolean = true;
		
		private var roll:Boolean = false;
		
		public var reading:Boolean = false;
		var attacking:Boolean = false;
		
		
		
		public function Sean(screen:GameScreen)
		{
			GameManager.sean = this;
			this.gameScreen = screen;
			x = 590;
			y = 420;
			scaleX = 2;
			scaleY = 2;
			stats = new Stats(10, 100, 100);
			mouseEnabled = false;
			description = "Handsome fellow.";
			
			displayName = "Sean";
			
			inventory = new Inventory(this);
			phone = new Phone();
			
			GameManager.ui.SetStamina(stats.stamina);
			GameManager.ui.SetHealth(stats.health);
			GameManager.ui.SetInventory(inventory);
			
			this.hurtSounds = new Array(new HurtOne());
			
			super.Initialize();
		}
		
		public override function Initialize() {
			GameManager.main.stage.addEventListener(KeyboardEvent.KEY_DOWN, KeyDown);
			GameManager.main.stage.addEventListener(KeyboardEvent.KEY_UP, KeyUp);
			GameManager.main.addEventListener(MouseEvent.CLICK, Attack);
			gotoAndStop("Idle");
			weaponSlot = new WeaponSlot(this);
		}
		
		private function Attack(e:MouseEvent) {
			if(stats.stamina >= AbilityCosts.ATTACK) {
				if (!attacking && weaponSlot.GetWeapon() != null && !roll && currentLabel == "Idle" && !phone.inCall) {
					attacking = true;
					seanBody.addEventListener("CheckHit", CheckHit);
					seanBody.body.gotoAndPlay("Attack1");
					seanBody.addEventListener("AttackFinished", EndAttack);
					stats.stamina -= AbilityCosts.ATTACK;
				}
			}
		}
		
		private function CheckHit(e:Event) {
			GameManager.gameScreen.GetRoom().AttackEntities(this, weaponSlot.GetWeapon());
			seanBody.removeEventListener("CheckHit", CheckHit);
		}
		
		private function EndAttack(e:Event) {
				attacking = false;
				if (seanBody.legs.currentLabel == "Walk") {
					seanBody.removeEventListener("AttackFinished", EndAttack);
					seanBody.body.gotoAndPlay("Walk");
				} else if (seanBody.legs.currentLabel == "Idle") {
					seanBody.body.gotoAndStop("Idle");
					seanBody.removeEventListener("AttackFinished", EndAttack);
				}
		}
		
		public override function Update():void {
			phone.Check();
			
			if(stats.stamina < stats.maxStamina) {
				if(sprintResetTimer > 0) {
					sprintResetTimer--;
				} else {
					stats.stamina++;
				}
			}
			
			if (stats.health <= 0) {
				Die();
			}
			
			var newX:int = x;
			var newY:int = y;
			
			var speed:int = stats.speed;
			var canSprint:Boolean = false;
			
			if(moveLeft || moveRight || moveDown || moveUp) {
				if(sprint) {
					if(stats.stamina - AbilityCosts.RUN >= 0) {
						speed = stats.runSpeed;
						canSprint = true;
					} else {
						if(stats.stamina != 0) {
							speed = stats.runSpeed;
							canSprint = true;
						}
					}
				}
			}
			
			if(moveLeft) {
				newX -= speed;
				scaleX = -2;
				
			} else if (moveRight) {
				newX += speed;
				scaleX = 2;
			}
			
			if(moveUp) {
				newY -= speed;
			} else if (moveDown) {
				newY += speed;
			}
			
			if (roll) {
				speed = stats.runSpeed;
				if (scaleX > 0) {
					newX += speed;
				} else if (scaleX < 0) {
					newX -= speed;
				}
			}
			
			if (!moveUp && !moveRight && !moveDown && !moveLeft && !roll) {
				StartIdle();
			}
			
			if(!knockedBack) {
				if (newX != x || newY != y) {
					var lastX:int = x;
					var lastY:int = y;
					
					x = newX;
					y = newY;
					
					if(gameScreen.GetRoom().CheckAble(this)) {
						if(canSprint) {
							stats.stamina -= AbilityCosts.RUN;
							sprintResetTimer = sprintResetMaxTime;
							if(stats.stamina < 0) {
								stats.stamina = 0;
							}
						}

						if (!roll) {
							StartWalk();
						}
					} else {
						x = lastX;
						y = lastY;
						if(!roll) {
							StartIdle();
						}
					}
				}
			}
				

			
			newX = 0;
			newY = 0;
			
			speed = 0;
			canSprint = false;
				
			if(GameManager.ui.GetStamina() != stats.stamina) {
				GameManager.ui.SetStamina(stats.stamina);
			}
			if(GameManager.ui.GetHealth() != stats.health) {
				GameManager.ui.SetHealth(stats.health);
			}
		}
		
		private function Die() {
			GameManager.gameScreen.SetRoom(RoomNames.lastRoom, GameManager.gameScreen.GetRoom().lastRoom);
			stats.health = stats.maxHealth;
			stats.stamina = stats.maxStamina;
		}
		
		private function StartWalk() {
			if (currentLabel != "Idle") {
				gotoAndStop("Idle");
			}
			
			if (weaponSlot.GetWeapon() != null) {
				AddWeaponToHand();
			}
			
			if(seanBody.body.currentLabel != "Walk" && !attacking) {
				seanBody.body.gotoAndPlay("Walk");
			}
			if(seanBody.legs.currentLabel != "Walk") {
				seanBody.legs.gotoAndPlay("Walk");
			}
			if(seanBody.head.currentLabel != "Walk") {
				seanBody.head.gotoAndPlay("Walk");
			}
		}
		
		public function KeyDown(e:KeyboardEvent):void {
			if(!reading) {
				if(e.keyCode == Keys.SPRINT) {
					if(stats.stamina >= AbilityCosts.RUN * 5) {
						sprint = true;
					}
				}
				
				if(e.keyCode == Keys.LEFT) {
					moveLeft = true;
					moveRight = false;
				} else if (e.keyCode == Keys.RIGHT) {
					moveRight = true;
					moveLeft = false;
				}
				
				if(e.keyCode == Keys.UP) {
					moveUp = true;
					moveDown = false;
				} else if (e.keyCode == Keys.DOWN) {
					moveDown = true;
					moveUp = false;
				}
				
				if (e.keyCode == Keys.ROLL && !roll) {
					if (stats.stamina >= AbilityCosts.ROLL) {
						if (attacking) {
							EndAttack(null);
						}
						immune = true;
						roll = true;
						gotoAndStop("Roll");
						addEventListener("rollFinished", RollFinished);
						stats.stamina -= AbilityCosts.ROLL;
					}
				}
				
				for (var i:int = 0; i < Keys.slots.length; i++) {
					if (e.keyCode == Keys.slots[i]) {
						inventory.SetSlot(i);
						break;
					}
				}
			}
		}
		
		private function RollFinished(e:Event) {
			roll = false;
			immune = false;
			if(!moveLeft && !moveRight && !moveUp && !moveDown) {
				StartIdle();
			} else {
				StartWalk();
			}
		}
		
		private function StartIdle() {
			if (currentLabel != "Idle") {
				gotoAndStop("Idle");
			}
			if (weaponSlot.GetWeapon() != null) {
				AddWeaponToHand();
			}
			seanBody.head.gotoAndPlay("Idle");
			if(!attacking) {
				seanBody.body.gotoAndPlay("Idle");
			}
			seanBody.legs.gotoAndPlay("Idle");
		}
		
		public function KeyUp(e:KeyboardEvent):void {
			if(e.keyCode == Keys.SPRINT) {
				sprint = false;
			}
			
			if(e.keyCode == Keys.LEFT) {
				moveLeft = false;
			}
			if(e.keyCode == Keys.RIGHT) {
				moveRight = false;
			}
			if(e.keyCode == Keys.UP) {
				moveUp = false;
			}
			if(e.keyCode == Keys.DOWN) {
				moveDown = false;
			}
		}
		
		public function GetInventory():Inventory {
			return inventory;
		}
		
		public function SetWeapon(weapon:Weapon) {
			weaponSlot.SetWeapon(weapon);
			AddWeaponToHand();
		}
		
		private function AddWeaponToHand() {
			if(currentLabel == "Idle") {
				if(seanBody.body.weaponHolder.numChildren < 2) {
					seanBody.body.weaponHolder.addChild(weaponSlot);
				}
			}
		}
		
		public function RemoveWeapon() {
			weaponSlot.RemoveWeapon();
		}
	}
}