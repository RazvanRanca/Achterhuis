package Entities 
{
	import net.flashpunk.Entity;
	
	/**
	 * ...
	 * @author Haggis
	 */
	public class EnemyHitBox extends Entity 
	{
		public function EnemyHitBox() 
		{
			super();
			setHitbox(Global.ENEMY_HIT_BOX.width, Global.ENEMY_HIT_BOX.height, Global.ENEMY_HIT_BOX.x, Global.ENEMY_HIT_BOX.y);
			type = "enemyHitBox";
		}
		
				
	}

}