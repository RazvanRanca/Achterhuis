package Entities 
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	
	/**
	 * ...
	 * @author Haggis
	 */
	public class PickableObject extends Entity 
	{
		private var justDropped:Boolean = false;
		
		public function PickableObject(x:int, y:int, t:int) 
		{
			super(x, y);
			graphic = new Image(Assets.OBJECT_ARRAY[t]);
			setHitbox(Image(graphic).width, Image(graphic).height);
			type = "pickableObject";
		}
		
		override public function update():void {
			if (Input.pressed(Key.SPACE) && collideWith(Global.PLAYER, x, y) && !justDropped) {
				visible = false;
				Global.PLAYER.pickUp(this);
				
			}
			justDropped = false;
			super.update();
		}
		
		public function dropObject():void {
			x = Global.PLAYER.x;
			y = Global.PLAYER.y;
			visible = true;
			justDropped = true;
		}
		
	}

}