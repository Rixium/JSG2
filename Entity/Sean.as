package Entity
{
	
	import Items.DoorKey;
	import Items.Item;
	import flash.display.MovieClip;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	import Constants.GameManager;
	import Constants.Keys;
	import Constants.RoomNames;
	
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
		
		public function Sean(screen:GameScreen)
		{
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
			
			inventory.AddItem(new DoorKey(RoomNames.MASROOM));
			
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
			
			if (!moveUp && !moveRight && !moveDown && !moveLeft) {
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
					if(currentLabel != "Walk") {
						gotoAndStop("Walk");
					}
				} else {
					x = lastX;
					y = lastY;
					if(currentLabel != "Idle") {
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
		
		public function GetItem():Item {
			if(inventory.selectedItem != null) {
				return inventory.selectedItem;
			} else {
				return null;
			}
		}
	}
}