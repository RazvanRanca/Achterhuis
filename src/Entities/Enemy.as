package Entities 
{
	import flash.geom.Point;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.Mask;
	import net.flashpunk.masks.Pixelmask;
	/**
	 * ...
	 * @author Haggis
	 */
	public class Enemy extends MovableBody
	{
		private var nodes:Array;
		private var nextNode:uint = 0;
		private var speedPerSec:uint = 90;
		private var closeEnough:uint = 1;
		private var fov:Image;
		private var sprites:Spritemap;
		private var looking:Boolean = false;
		private var timer:Number = 0;
		private var changeDir:int = 5;
		private var changeLook:uint = 5;
		private var playerNodes:Array = new Array();
		private var spottedPlayer:Boolean = false;
		private var nextPlayerNode:uint = 0;
		private var fovFactor:Number = 25;
		private var myHitBox:EnemyHitBox;
		private var randomTurns:int = 0;
		private var lostPlayer:Boolean = false;
		private var sawPlayerTimer:Number = 0;
		private var movedTimer:Number = 0;
		private var currentDirection:String = "west";
		private var dirs:Array = new Array("north", "west", "east", "south");
		
		public function Enemy(x:int, y:int, n:Array, e:EnemyHitBox) 
		{
			super(x, y);
			nodes = n;
							
			type = "enemy";
			sprites = new Spritemap(Assets.ENEMY_SPRITE_SHEET, 16, 16);
			sprites.add("standLeft", [8,8,8,8,8], 0.2,false);
			sprites.add("standRight", [0,0,0,0,0], 0.2,false);
			sprites.add("standUp", [13,13,13,13,13], 0.2,false);
			sprites.add("standDown", [5,5,5,5,5], 0.2,false);
			sprites.add("walkUp", [6,7], 2, true);
			sprites.add("walkDown", [4,5], 2, true);
			sprites.add("walkRight", [2,3], 2, true);
			sprites.add("walkLeft", [0,1], 2, true);
			
			graphic = sprites;
			changeMask(0);
			
			myHitBox = e;
			
			dirify(dirs[(int)(Math.random() * 4)]);
			setHitbox(16, 6, 0, -10);
		}
		
		public function changeMask(index:uint):void {
			
			mask = new Pixelmask(Assets.ENEMY_FOV_ARRAY[index], Global.ENEMY_FOV_OFFSET_ARRAY[index].x, Global.ENEMY_FOV_OFFSET_ARRAY[index].y);
			/*fov = new Image(Assets.ENEMY_FOV_ARRAY[index]);
			
			fov.x = Global.ENEMY_FOV_OFFSET_ARRAY[index].x;
			fov.y = Global.ENEMY_FOV_OFFSET_ARRAY[index].y
			graphic = new Graphiclist(fov, sprites);*/
		}
		
		private function dirify(s:String):void {
			currentDirection = s;
			switch(s) {
				case "north": turnAround(3); break;
				case "east": turnAround(0); break;
				case "west": turnAround(2); break;
				case "south": turnAround(1); break;
			}
		}
		
		override public function update():void 
		{
			if(nodes.length > 1) {
				if (!spottedPlayer && checkPlayerCollision()) {
					//spottedPlayer = true;
					playerNodes.push(new Point(Global.PLAYER.x, Global.PLAYER.y));
				}
				if (!spottedPlayer)
					normalBeat();
				else {
					if (lostPlayer)
						returnToPath()
					else
						followPlayer();
				}
			}
			else {
				var xC:int = 0;
				var yC:int = 0;
				switch (currentDirection) {
					case "north": xC = 0; yC = -1; break;
					case "west":  xC = -1; yC = 0; break;
					case "east": xC = 1; yC = 0; break;
					case "south": xC = 0; yC = 1; break;
				}
				var p:Point = new Point(this.x + xC, this.y + yC)
				if (!myHitBox.collide("wall", p.x, p.y))
				FP.stepTowards(this, this.x+xC, this.y+yC, speedPerSec * FP.elapsed);
				else
				dirify(dirs[(int)(Math.random() * 4)]);
				
				if (checkPlayerCollision()) {
					spottedPlayer = true;
					FP.stepTowards(this, Global.PLAYER.x, Global.PLAYER.y, speedPerSec * FP.elapsed *0.8);
					var a:int = angleTo(Global.PLAYER, this);
					if (a < 45 || a > 315) { dirify("north"); }
					if (a >= 45 && a < 135) { dirify("east"); }
					if (a >= 135 && a < 225) {dirify("south"); }
					if (a >= 225 && a < 315) { dirify("west");}
					
					if (distanceTo(this, Global.PLAYER) < 8) { 
						trace("DIEDIEDIE");
					}
					
				}

		//		FP.stepTowards(this, tempX, tempY, speedPerSec * FP.elapsed);
				
			}
			
			myHitBox.x = x;
			myHitBox.y = y;
			
			super.update();
		}
			
		public function angleTo(a, b):Number {
			var dx:Number = a.x - b.x;
			var dy:Number = a.y - b.y;
			var radians:Number = Math.atan2(dy,dx);
			var degrees:Number = radians * (180/Math.PI);
			return degrees+90;
		}
		
		
		public static function distanceTo(a, b):Number {
			var distance = Math.sqrt(((a.x - b.x) * (a.x - b.x)) + ((a.y - b.y) * (a.y - b.y)));
			if (distance < 0) { distance = distance * -1; }
			return distance;
		}
		
		public function normalBeat():void {
			
			var tempX:Number = nodes[nextNode].x;
			var tempY:Number = nodes[nextNode].y;
						
			if (looking)
				timer += FP.elapsed;
				
			if (FP.distance(x,y,tempX,tempY) < closeEnough && !looking) {
				nextNode++;
				if (nextNode >= nodes.length)
					nextNode = 0;
				var distX:Number = nodes[nextNode].x - x;
				var distY:Number = nodes[nextNode].y - y;
								
				changeDir = getDir(distX, distY);	
				changeLook = 0;
				looking = true;
								
			}
				if (changeLook < 4 && timer > 1) {
					
					timer = 0;
					lookAround(changeLook);
					if (checkPlayerCollision()) {
						spottedPlayer = true;
						sawPlayerTimer = 0;
						playerNodes.push(new Point(Global.PLAYER.x, Global.PLAYER.y));
						looking = false;
						changeLook = 5;
						timer = 0;
					}
					changeLook ++;
				}
				else
					if (looking && changeLook > 3 && !spottedPlayer && timer > 1) {
					changeLook = 5;
					looking = false;
					timer = 0;
					turnAround(changeDir);
				}
			
			if(!looking && !spottedPlayer) {
				var p:Point = new Point(x, y);
				FP.stepTowards(p, tempX, tempY, speedPerSec * FP.elapsed);
				if (!myHitBox.collide("wall", p.x, p.y))
					FP.stepTowards(this, tempX, tempY, speedPerSec * FP.elapsed);
				
			}
			
			
		}
		
		public function checkPlayerCollision():Boolean {
			if (!collideWith(Global.PLAYER, x, y))
				return false;
			else {
				var a:Array = new Array();
				collideInto("wall", x, y, a);
				for each (var s:Wall in a) {
					for (var i:int = 0; i < s.width / Global.GRID_SIZE; i++)
						for (var j:int = 0; j < s.height / Global.GRID_SIZE; j++)
							var dxW:Number = x - (s.x + i*Global.GRID_SIZE);
							var dyW:Number = y - (s.y + j*Global.GRID_SIZE);
							var dxP:Number = x - Global.PLAYER.x;
							var dyP:Number = y - Global.PLAYER.y;
							if (Math.sqrt(dxW * dxW + dyW * dyW) < Math.sqrt(dxP * dxP + dyP * dyP))// && (Math.abs(dxP - dxW) < fovFactor || Math.abs(dyP - dyW) < fovFactor))
								return false;
				
				}
			}
			return true;
		}
		
		public function lookAround(changeLook:uint):void {
			
			switch(changeLook) {
					case(0):
						sprites.play("standLeft");
						changeMask(3);
						break;
					case(1):
						sprites.play("standDown");
						changeMask(2);
						break;
					case(2):
						sprites.play("standRight");
						changeMask(1);
						break;
					default:
						sprites.play("standUp");
						changeMask(0);
						break;
					}
		}
		
		public function turnAround(changeDir:int):void {
			switch(changeDir) {
					case(0):
						sprites.play("walkRight");
						changeMask(1);
						break;
					case(1):
						sprites.play("walkDown");
						changeMask(2);
						break;
					case(2):
						sprites.play("walkLeft");
						changeMask(3);
						break;
					default:
						sprites.play("walkUp");
						changeMask(0);
						break;
					}
		}
		
		public function followPlayer():void {
			sawPlayerTimer += FP.elapsed;
			if (nextPlayerNode < playerNodes.length) {
				var tempX:Number = playerNodes[nextPlayerNode].x;
				var tempY:Number = playerNodes[nextPlayerNode].y;
			}
								
			if (looking) {
				timer += FP.elapsed;
				
			}
			//trace(x, y, tempX, tempY);
			if (FP.distance(x, y, tempX, tempY) < closeEnough && !looking) {
				if (collideWith(Global.PLAYER, x,y)) {
						playerNodes.push(new Point(Global.PLAYER.x, Global.PLAYER.y));
						sawPlayerTimer = 0;
				}
						
				nextPlayerNode++;
				//trace(nextPlayerNode, playerNodes);
				if (nextPlayerNode >= playerNodes.length) {
					//trace("look");
					looking = true;
					changeLook = 0;
					timer = 0;
				}
				else {
					//trace("dir");
					changeDir = getDir(playerNodes[nextPlayerNode].x - x, playerNodes[nextPlayerNode].y - y);
					turnAround(changeDir);
				}
				
			}
				if (changeLook < 4 && timer > 0.2) {
					
					timer = 0;
					lookAround(changeLook);
					if (collideWith(Global.PLAYER, x,y)) {
						playerNodes.push(new Point(Global.PLAYER.x, Global.PLAYER.y));
						sawPlayerTimer = 0;
					}
					changeLook ++;
				}
				else
					if (looking && changeLook > 3 && timer > 0.2) {
					changeLook = 5;
					looking = false;
					timer = 0;
					
					if (nextPlayerNode >= playerNodes.length) {
						changeDir = int(FP.rand(4));
						randomTurns++;
						if (randomTurns > 5) {
							lostPlayer = true;
							looking = false;
							nextPlayerNode--;
							movedTimer = 0;
						}
					}
					else {
						changeDir = getDir(playerNodes[nextPlayerNode].x - x, playerNodes[nextPlayerNode].y - y);
					}
					turnAround(changeDir);
					switch(changeDir) {
						case(0): playerNodes.push(new Point(x , y - Math.random() *150 + 50));
								break;
						case(1):playerNodes.push(new Point(x + Math.random() *150 - 50, y));
								break;
						case(2):playerNodes.push(new Point(x , y - Math.random() *150 + 50));
								break;
						case(3):playerNodes.push(new Point(x - Math.random() *150 + 50, y));
								break;
					}
					
				}
			
			if (!looking) {
				tempX = playerNodes[nextPlayerNode].x;
				tempY = playerNodes[nextPlayerNode].y;
				var p:Point = new Point(x, y);
				FP.stepTowards(p, tempX, tempY, speedPerSec * FP.elapsed);
				if (!myHitBox.collide("wall", p.x, p.y))
					FP.stepTowards(this, tempX, tempY, speedPerSec * FP.elapsed);
			}	
			if (sawPlayerTimer > 5) {
						lostPlayer = true;
						looking = false;
						nextPlayerNode--;
						movedTimer = 0;
			}
			
		}
		
		public function returnToPath():void {
			movedTimer += FP.elapsed;
			var exit:Boolean = false;
			
			while (nextPlayerNode >= playerNodes.length)
				nextPlayerNode--;
			if (nextPlayerNode < 0) {
				spottedPlayer = false;
				return;
			}
			var tempX:Number = playerNodes[nextPlayerNode].x;
			var tempY:Number = playerNodes[nextPlayerNode].y;
						
			if (looking)
				timer += FP.elapsed;
				
			if (FP.distance(x,y,tempX,tempY) < closeEnough && !looking) {
				nextPlayerNode--;
				if (nextPlayerNode < 0) {
					spottedPlayer = false;
					exit = true;
					return;
				}
				if(!exit){
				var distX:Number = playerNodes[nextPlayerNode].x - x;
				var distY:Number = playerNodes[nextPlayerNode].y - y;
								
				changeDir = getDir(distX, distY);	
				changeLook = 0;
				looking = true;
								
			}
				if (changeLook < 4 && timer > 0.2) {
					
					timer = 0;
					lookAround(changeLook);
					if (checkPlayerCollision()) {
						lostPlayer = false;
						playerNodes = new Array();
						playerNodes.push(new Point(Global.PLAYER.x, Global.PLAYER.y));
						looking = false;
						changeLook = 5;
						timer = 0;
					}
					changeLook ++;
				}
				else
					if (looking && changeLook > 3 && lostPlayer && timer > 0.2) {
					changeLook = 5;
					looking = false;
					timer = 0;
					turnAround(changeDir);
				}
			}
			
			if(lostPlayer) {
				var p:Point = new Point(x, y);
				FP.stepTowards(p, tempX, tempY, speedPerSec * FP.elapsed);
				if (!myHitBox.collide("wall", p.x, p.y)) {
					FP.stepTowards(this, tempX, tempY, speedPerSec * FP.elapsed);
					movedTimer = 0;
				}
				else
					FP.stepTowards(this, tempX, tempY, -1*speedPerSec * FP.elapsed);
				
			}
			if (movedTimer > 1) {
				nextPlayerNode--;
				movedTimer = 0;
			}
			
		}
		
		
		
		public function getDir(distX:Number, distY:Number):int {
			var changeDir:int;
			if(Math.abs(distX) > Math.abs(distY)){
			if (distX > 0)
				changeDir =0;
			else 
				if (distX < 0)
					changeDir = 2;
			
			}
			else {
					if (distY > 0)
						changeDir = 1;
					else
						changeDir =3;
				}
			
		return changeDir;
		}	
				
	}

}