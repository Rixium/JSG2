package Sounds 
{
	import flash.media.Sound;
	import flash.media.SoundLoaderContext;
	import flash.net.URLRequest;
	
	/**
	 * ...
	 * @author Rixium
	 */
	public class HangupSound extends Sound 
	{
		
		public function HangupSound(stream:URLRequest=null, context:SoundLoaderContext=null) 
		{
			super(stream, context);
			
		}
		
	}

}