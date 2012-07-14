package Entities 
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import Worlds.Transition;
	
	/**
	 * ...
	 * @author Haggis
	 */
	public class Door extends Entity 
	{
			
		public function Door(x:int,y:int,t:int) 
		{
			super(x, y);
			
			switch(t) {
				case(0):
					graphic = new Image(Assets.DOOR_0);
					break;
				default:
					graphic = new Image(Assets.DOOR_1);
					break;
			}
			setHitbox(Image(graphic).width, Image(graphic).width);
			visible = false;
			type = "Door";
		}
		
		override public function update():void {
			
			if (Input.pressed(Key.SPACE) && collideWith(Global.PLAYER, x, y))
				{
					if(Assets.LEVEL_CONSTRANINTS_ARRAY[Global.NEXT_LEVEL-1] == 0 || Global.PLAYER.object)
						if (Assets.LEVEL_STORY_ARRAY[Global.NEXT_LEVEL - 1] == 1)
							FP.world = new Transition(true);
						else
							FP.world = new Transition(false,true);
				}
			
			
			super.update();
		}
	}
}