package Entities 
{
	import flash.geom.Point;
	import net.flashpunk.FP;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	/**
	 * ...
	 * @author Haggis
	 */
	public class VIP extends RailMovement 
	{
		private var level:int;
		private var item:int;
		private var dropped:Boolean = false;
		private var dropRange:int = 10;
		public function VIP(x:int,y:int,type:int, p1:Point,p2:Point,l:int) 
		{
			super(x, y, type, p1, p2);
			level = l;
			item = type;
		}
		
		override public function update():void {
			if (Input.pressed(Key.SPACE) && FP.distance(x,y,Global.PLAYER.x,Global.PLAYER.y)< dropRange && level == Global.NEXT_LEVEL-1 && !dropped){
				Global.GAME.add(new PickableObject(x, y + 10, item));
				dropped = true;
			}
			super.update();
		}
		
		override public function speak():void {
			
			//Global.DIALOG_BOX.setText("hmm", 2);
		}
		
	}

}