package Entities 
{
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	
	/**
	 * ...
	 * @author Haggis
	 */
	public class Player extends MovableBody
	{
		private const speedPerSec:uint = 100;
		private const slowSpeed:uint = 90;
		public var object:PickableObject;
		private var pickUpTimer:Number = 0;
		private var sprites:Spritemap;
		
		public function Player(x:int,y:int) 
		{
			super(x, y);

			Input.define("up", Key.UP, Key.W)
			Input.define("down", Key.DOWN, Key.S)
			Input.define("left", Key.LEFT, Key.A)
			Input.define("right", Key.RIGHT, Key.D)
			setHitbox(16, 6, 0, -10);
			
			sprites = new Spritemap(Assets.PLAYER_SPRITE, 16, 16);
			sprites.add("walkUp", [6,7], 3, true);
			sprites.add("walkDown", [4,5], 3, true);
			sprites.add("walkRight", [2,3], 3, true);
			sprites.add("walkLeft", [0, 1], 3, true);


			graphic = new Graphiclist(sprites);
		}
		
		override public function update():void {
			var speed:int = speedPerSec;
			if (pickUpTimer > 0)
				pickUpTimer -= FP.elapsed;
			if (object)
				speed = slowSpeed;
			graphic.active = false;
			if (Input.check("up")){
				tryMovement(false, int( -1 * speed * FP.elapsed));
				sprites.play("walkUp");
				graphic.active = true;
				}
			if (Input.check("down")){
				tryMovement(false, int(speed * FP.elapsed));
				sprites.play("walkDown");
				graphic.active = true;
				}
			if (Input.check("left")){
				tryMovement(true, int( -1 * speed * FP.elapsed));
				sprites.play("walkLeft");
				graphic.active = true;
				}
			if (Input.check("right")){
				tryMovement(true, int(speed * FP.elapsed));
				sprites.play("walkRight");
				graphic.active = true;
				}
			
			
			super.update();
		}
		
		public function pickUp(po:PickableObject):void {
			object = po;
			pickUpTimer = 1;
			if (Global.NEXT_LEVEL == 2)
				Global.DIALOG_BOX.setText("Now take the food back home.", 4, true);
		}
	}
}