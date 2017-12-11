package Entity 
{
	import flash.display.MovieClip;
	/**
	 * ...
	 * @author Rixium
	 */
	public class LaserBeam extends MovieClip
	{
		
		public function LaserBeam() 
		{
			
		}
		
		public function Kill() {
			parent.removeChild(this);
		}
		
	}

}