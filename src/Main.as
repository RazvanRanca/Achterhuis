package 
{
	
	import flash.events.ContextMenuEvent;
	import net.flashpunk.Engine;
	import net.flashpunk.FP;
	import Worlds.Menu;
	
	/**
	 * ...
	 * @author Haggis
	 */
	public class Main extends Engine
	{
		
		public function Main():void 
		{
			super(640, 480, 40, false);
			FP.console.enable();
		}
		
		override public function init():void 
		{
			FP.world = new Menu();
		}
		
	}
	
}