package Entity
{
	public class Stats
	{
		
		public var speed:int;
		public var runSpeed:int;
		public var health:int;
		public var maxHealth:int;
		public var stamina:int;
		public var maxStamina:int;
		
		public function Stats(speed:int, health:int, stamina:int)
		{
				this.speed = speed;
				this.runSpeed = speed * 2 + 5;
				this.health = health;
				this.maxHealth = health;
				this.stamina = stamina;
				this.maxStamina = stamina;
		}
	}
}