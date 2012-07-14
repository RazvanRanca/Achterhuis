package Entities 
{
	import flash.geom.Point;
	import net.flashpunk.Entity;
	
	/**
	 * ...
	 * @author Haggis
	 */
	public class LineOfSight extends Entity 
	{
		
		public var t:Point;
		
		public function LineOfSight(sx:int, sy:int, tx:int, ty:int) 
		{
			super(sx, sy);
			t = new Point(tx, ty);
			
		}
		
	}

}