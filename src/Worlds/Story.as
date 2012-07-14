package Worlds 
{
	import Entities.Button;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.World;
	
	/**
	 * ...
	 * @author Haggis
	 */
	public class Story extends World 
	{
		private var timer:Number = 0;
		private const WAIT_TIME:Number = 3;
		private var stillWaiting:Boolean = true;
		private var continueButton:Button = null;
		
		public function Story() 
		{
			super();
			
			
			
		}
		
		override public function update():void
		{
			timer += FP.elapsed;
			
			if (timer > WAIT_TIME) {
				
				if (!continueButton) {
					
					continueButton = new Button(500, 400, 150, 70, startGame);
					continueButton.normal = new Image(Assets.PLAY_BUTTON_NORMAL);
					continueButton.down = new Image(Assets.PLAY_BUTTON_DOWN);
					continueButton.hover = new Image(Assets.PLAY_BUTTON_HOVER);
					add(continueButton);
				}
			}
			super.update();
		}
		
		public function startGame():void
		{
			if (!Global.GAME)
				Global.GAME = new Game();
				
			FP.world = new Transition(false,true);
		}
		
		public function nextStory():void
		{
			removeAll();
			continueButton = null;
			var e:Entity = new Entity(0, 0, new Image(Assets.STORY_ARRAY[Global.NEXT_STORY++]));
			add(e);
			timer = 0;
			
		}
		
	}

}