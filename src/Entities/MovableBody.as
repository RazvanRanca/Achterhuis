package Entities 
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	
	/**
	 * ...
	 * @author Haggis
	 */
	public class MovableBody extends Entity 
	{
		
		public function MovableBody(x:int, y:int) 
		{
			super(x, y);
		}
		
		protected function tryMovement(movingX:Boolean, ammount:int):void {
			
			var tempX:int = x;
			var tempY:int = y;
			if (movingX) {
				
				for (var i:int = 0; i < Math.abs(ammount); i++)
					if (!collide("wall", tempX + FP.sign(ammount), y))
						tempX += FP.sign(ammount);
				
				x = tempX;
				
			}
			else {
				for (i = 0; i < Math.abs(ammount); i++)
					if (!collide("wall", x, tempY + FP.sign(ammount)))
						tempY+=FP.sign(ammount);
				y = tempY;
			}
					
		}
		
	}

}