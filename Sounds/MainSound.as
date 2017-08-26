package Sounds 
{
	import flash.media.Sound;
	import flash.media.SoundLoaderContext;
	import flash.net.URLRequest;
	
	/**
	 * ...
	 * @author Rixium
	 */
	public class MainSound extends Sound 
	{
		
		public function MainSound(stream:URLRequest=null, context:SoundLoaderContext=null) 
		{
			super(stream, context);
			
		}
		
	}

}