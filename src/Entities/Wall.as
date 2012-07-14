package Entities
{
	import net.flashpunk.Entity;
	
	/**
	 * ...
	 * @author Haggis
	 */
	public class Wall extends Entity 
	{		
		public function Wall(x:int,y:int,width:int,height:int) 
		{
			
			super(x, y);
			setHitbox(width, height);
			type = "wall";
			active = false;
			visible = false;
		}
		
	}

}