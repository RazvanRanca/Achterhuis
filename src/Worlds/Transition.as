package Worlds 
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.utils.Draw;
	import net.flashpunk.World;
	
	public class Transition extends World
	{
		
		public var screen:Image;
	
		public var display:Entity;
		
		public var story:Boolean;
		public var alpha:Number = 0;
		public var fast:Boolean;
		public function Transition(story:Boolean = false, f:Boolean = false ) 
		{
			screen = new Image(FP.buffer);
			fast = f;
			add(display = new Entity(0, 0, screen));
			
			this.story = story;
			
		}
		
		override public function render():void {
			//fade out
			super.render();
			Draw.rect(0, 0, FP.width, FP.height, 0x000000, alpha);
			if (fast)
				alpha = 1;
			else
				alpha += 0.5*FP.elapsed;
			
			
			//if we're done, go to the next world
			if (Math.floor(alpha) == 1) 
			{ 
				if(!story){
					FP.world = Global.GAME;
					Global.GAME.nextLevel(); 
				}
				else {
					FP.world = Global.STORY;
					Global.STORY.nextStory();
				}
			}
		}
	}

}