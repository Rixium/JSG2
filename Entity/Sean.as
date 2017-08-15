package Entity
{
	
	import Items.DoorKey;
	import Items.Item;
	import Objects.Door;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	import Constants.GameManager;
	import Constants.Keys;
	import Constants.RoomNames;
	import Constants.ItemImages;
	
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
		
		private var iKeyUp:Boolean = true;
		
		private var roll:Boolean = false;
		
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
			
			GameManager.ui.SetStamina(stats.stamina);
			GameManager.ui.SetHealth(stats.health);
			GameManager.ui.SetInventory(inventory);

		}
		
		public function Initialize():void {
			GameManager.main.stage.addEventListener(KeyboardEvent.KEY_DOWN, KeyDown);
			GameManager.main.stage.addEventListener(KeyboardEvent.KEY_UP, KeyUp);
		}

		
		public function Update():void {
			if(stats.stamina < stats.maxStamina) {
				if(sprintResetTimer > 0) {
					sprintResetTimer--;
				} else {
					stats.stamina++;
				}
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
				if(currentLabel != "Idle") {
					gotoAndStop("Idle");
				}
			}
			
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

					if(currentLabel != "Walk" && !roll) {
						gotoAndStop("Walk");
					}
				} else {
					x = lastX;
					y = lastY;
					if(currentLabel != "Idle" && !roll) {
						gotoAndStop("Idle");
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
		}
		
		public function KeyDown(e:KeyboardEvent):void {
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
				if(stats.stamina >= AbilityCosts.ROLL) {
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
		
		private function RollFinished(e:Event) {
			roll = false;
			gotoAndStop("Idle");
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
		
		public function GetStats():Stats {
			return stats;
		}
	}
}