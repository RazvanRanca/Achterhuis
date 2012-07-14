package Entities 
{
	import flash.geom.Point;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	
	/**
	 * ...
	 * @author Haggis
	 */
	public class RailMovement extends Entity 
	{
		
		private var p1:Point;
		private var p2:Point;
		private var range:int = 2;
		private var speed:int = 40;
		private var direction:Boolean; //true = left
		private var sprite:Spritemap;
		public function RailMovement(x:int,y:int,type:int, p1:Point,p2:Point) 
		{
			super(x, y);
			sprite = new Spritemap(Assets.RAIL_MOVEMENT_ARRAY[type],16,16);
			sprite.add("standRight", [0], 0, false);
			sprite.add("walkRight", [0,1], 3, true);
			sprite.add("standLeft", [3], 0, false);
			sprite.add("walkLeft", [2, 3],3 , true);		
			this.p1 = p1;
			this.p2 = p2;
			graphic = sprite;
			if (p1.x < p2.x) {
				direction = true;
				sprite.play("walkRight");
			}
			else {
				direction = false;
				sprite.play("walkLeft");
			}
			setHitbox(32, 32, -8, -8);
			
			
		}
		
		override public function update():void {
			if (collideWith(Global.PLAYER,x,y)) {
				speak();
			}
			if (FP.distance(x, y, p1.x, p1.y) < range) {
				var aux:Point = p1;
				p1 = p2;
				p2 = aux;
				if (direction) {
					direction = false;
					sprite.play("walkLeft");
				}
				else {
					direction = true;
					sprite.play("walkRight");
				}
			}
			FP.stepTowards(this, p1.x, p1.y, speed * FP.elapsed);
			super.update();
				
		}
		
		public function speak():void {
			//Global.DIALOG_BOX.setText("Howdy, there", 2);
			}
		
	}

}