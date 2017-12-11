package Entity
{
	public class Stats
	{
		
		public var speed:Number;
		public var runSpeed:Number;
		public var health:int;
		public var maxHealth:int;
		public var stamina:int;
		public var maxStamina:int;
		public var vision:int;
		
		public function Stats(speed:int, health:int, stamina:int)
		{
				this.speed = speed;
				this.runSpeed = speed * 2 + 5;
				this.health = health;
				this.maxHealth = health;
				this.stamina = stamina;
				this.maxStamina = stamina;
				this.vision = 400;
		}
	}
}