package  Worlds
{
	import Entities.Button;
	import flash.display.SimpleButton;
	import flash.geom.Point;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.utils.Input;
	import net.flashpunk.World;
	
	/**
	 * ...
	 * @author Haggis
	 */
	public class Menu extends World 
	{
		public function Menu() 
		{
			add(new Entity(0, 0, new Image(Assets.MAIN_MENU)));
			var b:Button = new Button(200, 200, 116, 60, startStory);
			add(b);
			b.normal = new Image(Assets.PLAY_BUTTON_NORMAL);
			b.hover = new Image(Assets.PLAY_BUTTON_HOVER);
			b.down = new Image(Assets.PLAY_BUTTON_DOWN);
		}
		
		public function startStory():void {
			if (!Global.STORY)
				Global.STORY = new Story();
			FP.world = new Transition(true,true);
		}
		
		
	}

}