package Entity
{
	
	import Chat.ChatLine;
	import Chat.Conversation;
	import Chat.Phone;
	import Items.DoorKey;
	import Items.HealthUpgradeItem;
	import Items.Item;
	import Items.StaminaUpgradeItem;
	import Items.WeaponItem;
	import Objects.Door;
	import Objects.Light;
	import Rooms.MasRoom;
	import Screens.YouDiedScreen;
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
		var startedDeath:Boolean = false;
		
		var gameScreen:GameScreen;
		
		var sprintResetTimer:int = 0;
		var sprintResetMaxTime:int = 20;

		var inventory:Inventory;
		var deathScreen:YouDiedScreen;
		var currentItem:Item;
		
		public var phone:Phone;
		
		private var iKeyUp:Boolean = true;
		
		private var roll:Boolean = false;
		
		private var light:Light;
		var lightSize = 400;
		
		public var numSteps:int = 0;
		public var reading:Boolean = false;
		var attacking:Boolean = false;
		public var ready:Boolean = true;
		private var isAttacking:Boolean = false;
		
		
		
		
		public function Sean(screen:GameScreen)
		{
			GameManager.sean = this;
			this.gameScreen = screen;
			x = 590;
			y = 420;
			scaleX = 2;
			scaleY = 2;
			
			xScale = scaleX;
			yScale = scaleY;
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
		
		private function GiveDebugItems() {
			var item:WeaponItem = new WeaponItem(ItemImages.BOW, WeaponTypes.BOW, 5);
			item.displayName = "Billy's Bow";
			item.description = "Better than nothing.";
			
			var item2:WeaponItem = new WeaponItem(ItemImages.SEPTICSWORD, WeaponTypes.SEPTICSWORD, 100);
			item2.displayName = "Sword";
			item2.description = "Too powerful debug weapon.";
			
			inventory.AddItem(item, true);
			inventory.AddItem(item2, true);
		}
		
		private function StopAttack(e:MouseEvent) {
			isAttacking = false;
		}
		
		private function StartAttack(e:MouseEvent) {
			isAttacking = true;
		}
		
		public override function Initialize() {
			GameManager.main.stage.addEventListener(KeyboardEvent.KEY_DOWN, KeyDown);
			GameManager.main.stage.addEventListener(KeyboardEvent.KEY_UP, KeyUp);
			GameManager.main.addEventListener(MouseEvent.MOUSE_DOWN, StartAttack);
			GameManager.main.addEventListener(MouseEvent.MOUSE_UP, StopAttack);
			
			gotoAndStop("Idle");
			weaponSlot = new WeaponSlot(this);
			
			//GiveDebugItems();
		}
		
		private function Attack() {
			if(!GameManager.gameScreen.paused) {
				if(stats.stamina >= AbilityCosts.ATTACK) {
					if (!attacking && weaponSlot.GetWeapon() != null && !roll && currentLabel == "Idle" && !phone.inCall) {
						attacking = true;
						switch(weaponSlot.GetWeapon().weaponStyle) {
							case WeaponStyles.SLASH:
								seanBody.addEventListener("CheckHit", CheckHit);
								seanBody.body.gotoAndPlay("Attack1");
								seanBody.addEventListener("AttackFinished", EndAttack);
								break;
							case WeaponStyles.SHOTGUN:
								seanBody.addEventListener("ShootBullets", ShootBullets);
								seanBody.body.gotoAndPlay("ShotgunAttack");
								seanBody.addEventListener("ShotgunFinished", EndAttack);
								break;
							case WeaponStyles.BOW:
							seanBody.addEventListener("ShootBullets", ShootBullets);
							seanBody.body.gotoAndPlay("BowAttack");
							seanBody.addEventListener("AttackFinished", EndAttack);
							break;
							default:
								break;
						}
						stats.stamina -= AbilityCosts.ATTACK;
					}
				}
			}
		}
		
		private function CheckHit(e:Event) {
			GameManager.gameScreen.GetRoom().AttackEntities(this, weaponSlot.GetWeapon());
			seanBody.removeEventListener("CheckHit", CheckHit);
			weaponSlot.GetWeapon().PlaySound();
		}
		
		private function EndAttack(e:Event) {
				attacking = false;
				if (seanBody.legs.currentLabel == "Walk") {
					seanBody.removeEventListener("AttackFinished", EndAttack);
					StartWalk();
				} else if (seanBody.legs.currentLabel == "Idle") {
					seanBody.removeEventListener("AttackFinished", EndAttack);
					StartIdle();
				}
		}
		
		public override function Update():void {
			super.Update();
			if (ready) {
				if (isAttacking) {
					Attack();
					if (GameManager.gameScreen.GetRoom().mouseX < getBounds(GameManager.gameScreen.GetRoom()).x + width / 2) {
						scaleX = -xScale;
					} else {
						scaleX = xScale;
					}
				}
				if (light != null ) {
					if(!roll) {
						light.x = weaponSlot.getBounds(GameManager.gameScreen.roomLayer).x + weaponSlot.width / 2 - lightSize / 2;
						light.y = weaponSlot.getBounds(GameManager.gameScreen.roomLayer).y + weaponSlot.height / 2 - lightSize / 2;
					} else {
						light.x = getBounds(GameManager.gameScreen.roomLayer).x + width / 2 - lightSize / 2;
						light.y = getBounds(GameManager.gameScreen.roomLayer).y + height / 2 - lightSize / 2;
					}
				}
				
				phone.Check();
				
				if(currentLabel != "ItemGet") {
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
						if(!isAttacking) {
							scaleX = -xScale;
						}
						
					} else if (moveRight) {
						newX += speed;
						if(!isAttacking) {
							scaleX = xScale;
						}
					}
					
					if(moveUp) {
						newY -= speed;
					} else if (moveDown) {
						newY += speed;
					}
					
					if (roll) {
						immune = true;
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
							
							if (gameScreen.GetRoom().CheckAble(this, false)) {
								
							} else {
								x = lastX;
							}

							y = newY;
							
							if (gameScreen.GetRoom().CheckAble(this, false)) {
								
							} else {
								y = lastY;
							}
							
							if (lastX != x || lastY != y) {
								if(canSprint) {
									stats.stamina -= AbilityCosts.RUN;
									sprintResetTimer = sprintResetMaxTime;
									if(stats.stamina < 0) {
										stats.stamina = 0;
									}
								}
								if (!roll) {
									StartWalk();
									numSteps++;
								}
							} else {
								if(!roll) {
									StartIdle();
								}
							}
							
							/*
							if(gameScreen.GetRoom().CheckAble(this, false)) {
								if(canSprint) {
									stats.stamina -= AbilityCosts.RUN;
									sprintResetTimer = sprintResetMaxTime;
									if(stats.stamina < 0) {
										stats.stamina = 0;
									}
								}
								if (!roll) {
									StartWalk();
									numSteps++;
								}
							} else {
								x = lastX;
								y = lastY;
								if(!roll) {
									StartIdle();
								}
							}
							*/
							
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
			}
		}
		
		private function Respawn(e:Event) {
			canKnockback = true;
			deathScreen.End();
			deathScreen = null;
			if(GameManager.gameScreen.GetRoom().lastRoom != RoomNames.CITY && GameManager.gameScreen.GetRoom().lastRoom != RoomNames.CITYVIEW) {
				GameManager.gameScreen.SetRoom(RoomNames.lastRoom, GameManager.gameScreen.GetRoom().lastRoom);
			} else if (GameManager.gameScreen.GetRoom().lastRoom == RoomNames.CITY){
				GameManager.gameScreen.SetRoom(RoomNames.CITY, RoomNames.ROOFTOP);
			} else if (GameManager.gameScreen.GetRoom().lastRoom == RoomNames.CITYVIEW) {
				GameManager.gameScreen.SetRoom(RoomNames.CITYVIEW, RoomNames.CITY);
				x = 200;
				y = 450;
			}
			
			startedDeath = false;
		}

		private function Die() {
			if (!startedDeath) {
				canKnockback = false;
				GameManager.gameScreen.GetRoom().canUpdate = false;
				GameManager.gameScreen.musicManager.PlayTrack(RoomTracks.NONE);
				GameManager.gameScreen.GetRoom().StopShake();
				GameManager.gameScreen.GetRoom().Clean();
				deathScreen = new YouDiedScreen();
				deathScreen.addEventListener("Finished", Respawn);
				GameManager.ui.addChild(deathScreen);
				stats.health = stats.maxHealth;
				stats.stamina = stats.maxStamina;
				startedDeath = true;
			}
		}
		
		private function StartWalk() {
			if (currentLabel != "Idle") {
				gotoAndStop("Idle");
			}
			
			if (weaponSlot.GetWeapon() != null) {
				AddWeaponToHand();
			}
			
			if ((seanBody.body.currentLabel != "Walk" && seanBody.body.currentLabel != "IdleShotgun") && !attacking) {
				if (weaponSlot.GetWeapon() == null || weaponSlot.GetWeapon().weaponStyle == WeaponStyles.SLASH) {
					seanBody.body.gotoAndPlay("Walk");
				} else if(weaponSlot.GetWeapon().weaponStyle == WeaponStyles.SHOTGUN) {
					seanBody.body.gotoAndStop("IdleShotgun");
				} else if (weaponSlot.GetWeapon().weaponStyle == WeaponStyles.BOW) {
					seanBody.body.gotoAndStop("IdleBow");
				}
			}
			if(seanBody.legs.currentLabel != "Walk") {
				seanBody.legs.gotoAndPlay("Walk");
			}
			if(seanBody.head.currentLabel != "Walk") {
				seanBody.head.gotoAndPlay("Walk");
			}
		}
		
		public function AddHealth(amount:int) {
			stats.health += amount;
			if (stats.health > stats.maxHealth) {
				stats.health = stats.maxHealth;
			}
			
			GameManager.ui.SetHealth(amount);
		}
		
		public function KeyDown(e:KeyboardEvent):void {
			if(ready && !GameManager.gameScreen.paused) {
				if(!reading && currentLabel != "ItemGet") {
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
					
					if (e.keyCode == Keys.ROLL && !roll && deathScreen == null) {
						if (stats.stamina >= AbilityCosts.ROLL) {
							if (attacking) {
								EndAttack(null);
							}
							immune = true;
							roll = true;
							numSteps += 15;
							seanBody.legs.gotoAndStop("Idle");
							gotoAndStop("Roll");
							addEventListener("PlayRollSound", PlayRollSound);
							addEventListener("rollFinished", RollFinished);
							stats.stamina -= AbilityCosts.ROLL;
						}
					}
					if (e.keyCode == Keys.ROLL && deathScreen != null) {
						deathScreen.ForceFade();
					}
					
					if (e.keyCode == Keys.BAG) {
						inventory.OpenBag();
					}
					
					for (var i:int = 0; i < Keys.slots.length; i++) {
						if (e.keyCode == Keys.slots[i]) {
							inventory.SetSlot(i);
							break;
						}
					}
				}
			}
		}
		
		private function PlayRollSound(e:Event) {
			removeEventListener("PlayRollSound", PlayRollSound);
			var rollTrans:SoundTransform = new SoundTransform(GameManager.soundLevel * 2, 0);
			channel = new RollSound().play(0, 0, rollTrans);
			rollTrans = null;
			channel = null;
		}
		private function RollFinished(e:Event) {
			roll = false;
			immune = false;
			if(!moveLeft && !moveRight && !moveUp && !moveDown) {
				StartIdle();
			} else {
				StartWalk();
			}
			removeEventListener("rollFinished", RollFinished);
		}
		
		public function Destroy() {
			GameManager.main.stage.removeEventListener(KeyboardEvent.KEY_DOWN, KeyDown);
			GameManager.main.stage.removeEventListener(KeyboardEvent.KEY_UP, KeyUp);
			GameManager.main.removeEventListener(MouseEvent.CLICK, Attack);
		}
		
		public function StartGetItem(){
			RollFinished(null);
			gotoAndStop("ItemGet");
		}
		
		public function StartIdle() {
			if (currentLabel != "Idle") {
				gotoAndStop("Idle");
			}
			if (weaponSlot.GetWeapon() != null) {
				AddWeaponToHand();
			}
			seanBody.head.gotoAndPlay("Idle");
			if (!attacking) {
				if(weaponSlot.GetWeapon() == null) {
					seanBody.body.gotoAndPlay("Idle");
				} else if (weaponSlot.GetWeapon().weaponStyle == WeaponStyles.SLASH) {
					seanBody.body.gotoAndPlay("Idle");
				} else if (weaponSlot.GetWeapon().weaponStyle == WeaponStyles.SHOTGUN) {
					seanBody.body.gotoAndPlay("IdleShotgun");
				} else if (weaponSlot.GetWeapon().weaponStyle == WeaponStyles.BOW) {
					seanBody.body.gotoAndStop("IdleBow");
				}
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
		
		private function ShootBullets(e:Event) {
			weaponSlot.GetWeapon().PlaySound();
			weaponSlot.GetWeapon().Shoot(scaleX, this);
		}
		
		public function SetWeapon(weapon:Weapon) {
			weaponSlot.SetWeapon(weapon);
			if (weapon.weaponType == WeaponTypes.TORCH) {
				light = new Light(weaponSlot.getBounds(GameManager.gameScreen.roomLayer).x + weaponSlot.width / 2 - lightSize / 2, weaponSlot.getBounds(GameManager.gameScreen.roomLayer).y + weaponSlot.height / 2 - lightSize / 2 , lightSize, lightSize);
				GameManager.gameScreen.GetRoom().lightMask.addChild(light);
			} else {
				if(light != null) {
					GameManager.gameScreen.GetRoom().lightMask.removeChild(light);
					light = null;
				}
			}
			AddWeaponToHand();
			if (currentLabel == "Idle") {
				StartIdle();
			} else if (currentLabel == "Walk") {
				StartWalk();
			}
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
			if (light != null) {
				GameManager.gameScreen.GetRoom().lightMask.removeChild(light);
				light = null;
			}
		}
	}
}