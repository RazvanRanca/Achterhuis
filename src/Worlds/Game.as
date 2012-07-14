package Worlds 
{
	import Entities.*;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Tilemap;
	import net.flashpunk.World;
	
	
	/**
	 * ...
	 * @author Haggis
	 */
	public class Game extends World 
	{
		
		private var tiles:Tilemap;
		private var roadNodes:Array = new Array();
		private var gameTimer:Number;
		private var xml:XML;
		public var curDoor:Door;
		
		public function Game() 
		{
			super();
			Global.DIALOG_BOX = new DialogBox();
			Global.TIME_LEFT = new DialogBox(true, 20, 20);
								
		}
		
		public function nextLevel():void
		{
			removeAll();			
			trace(Global.DAY);
			var n:int = ((Global.DAY - 1) * 2) + ((Global.INSIDE)?0:1);
			trace(n);
			var file:ByteArray = new Assets.LEVEL_ARRAY[Global.NEXT_LEVEL];
			Global.NEXT_LEVEL++;
			var str:String = file.readUTFBytes( file.length );
			xml = new XML(str);
			//trace(xml);
			FP.width = xml.width;
			FP.height = xml.height;
			
			
						var asset:Class = Assets.TILE_SHEET;
			if (Assets.LEVEL_TILES_ARRAY[Global.NEXT_LEVEL-1] == 0) asset = Assets.BASE_SHEET;
			tiles = new Tilemap(asset, FP.width, FP.height, Global.GRID_SIZE, Global.GRID_SIZE);
			add(new Entity(0, 0, tiles));
			
			curDoor = new Door(xml.actors.door.@x, xml.actors.door.@y, xml.actors.door.@leadsToLevel);
			add(curDoor);
			
			add(Global.PLAYER = new Player(xml.actors.player.@x, xml.actors.player.@y));
			add(Global.VIEW = new View(Global.PLAYER as Entity, new Rectangle(0, 0, FP.width, FP.height), 30));
			
			var x:XML;
			if (Global.LEVEL_HAS_OBJECT[Global.NEXT_LEVEL - 1]) {
				for each (x in xml.actors.object)
					add(new PickableObject(x.@x, x.@y, x.@objectType));
			}
			for each(x in xml.tilesAbove.tile)
				tiles.setTile(x.@x / Global.GRID_SIZE, x.@y / Global.GRID_SIZE, x.@id);
				
			for each(x in xml.tilesAbove.rect)
				tiles.setRect(x.@x / Global.GRID_SIZE, x.@y / Global.GRID_SIZE, x.@w/Global.GRID_SIZE, x.@h/Global.GRID_SIZE, x.@id);
				
			for each(x in xml.collidableGrid.rect)
				add(new Wall(x.@x, x.@y, x.@w, x.@h));
			
				
			for each(x in xml.actors.enemy) {
				
				var nodes:Array = new Array();
				nodes.push(new Point(x.@x, x.@y));
				
				for each (var y:XML in x.children())
					nodes.push(new Point(y.@x, y.@y));
					
				var e:EnemyHitBox = new EnemyHitBox();
				add(new Enemy(x.@x, x.@y, nodes, e));
				add(e);
			}
			
			for each(x in xml.actors.VIP) {
				var i:int = 0;
				var p1:Point;
				var p2:Point;
				for each(var q:XML in x.children()) {
					if (i == 0)
						p1 = new Point(q.@x, q.@y);
					else
						p2 = new Point(q.@x, q.@y)
					i++;
				}
				add(new VIP(x.@x, x.@y, x.@item, p1, p2,x.@onLevel));
			}
			for each(x in xml.actors.Civilian) {
				i = 0;
				for each(q in x.children()) {
					if (i == 0)
						p1 = new Point(q.@x, q.@y);
					else
						p2 = new Point(q.@x, q.@y)
					i++;
				}
				add(new RailMovement(x.@x, x.@y, x.@type, p1, p2));
			}
			
			for each(x in xml.actors.family) {
				if (x.@objectType== 0)
					add(new Entity(x.@x, x.@y, new Image(Assets.BROTHER)));
				if (x.@objectType == 1)
					add(new Entity(x.@x, x.@y, new Image(Assets.BROTHER1)));
				if(x.@objectType == 2) {
					i = 0;
					for each(q in x.children()) {
						if (i == 0)
							p1 = new Point(q.@x, q.@y);
						else
							p2 = new Point(q.@x, q.@y)
						i++;
					}
					add(new RailMovement(x.@x, x.@y, 4, p1, p2));
				}
			}
			add(Global.DIALOG_BOX);
			gameTimer = Global.GAME_TIMER_ARRAY[Global.NEXT_LEVEL -1];
			add(Global.TIME_LEFT);
			if (Global.NEXT_LEVEL == 2)
				Global.DIALOG_BOX.setText("You must find some food.", 4, true);
			if (Global.NEXT_LEVEL == 5)
				Global.DIALOG_BOX.setText("Your little brother is likely to the West. Find him.", 4, true);
			if (Global.NEXT_LEVEL == 7)
				Global.DIALOG_BOX.setText("Moshe has an infection. Find some medicine.", 4, true);
			if (Global.NEXT_LEVEL == 11)
				Global.DIALOG_BOX.setText("...managed to lose them, must find an exit ...", 4, true);
		}
		
		public function nextStory(storyIndex:uint):void
		{
			FP.world = new Transition(true);
		}
		
		override public function update():void {
			if (gameTimer != -1337) {
				gameTimer -= FP.elapsed;
				Global.TIME_LEFT.setText(int(gameTimer).toString());
				if (gameTimer <= 0) {
					tooSlow();
					Global.TIME_LEFT.setText("0");
					gameTimer = -1337;
				}
			}
		
		
			super.update();
			
		}
		
		private function tooSlow():void
		{
			for each(var x:XML in xml.actors.lateEnemy) {
				
				var nodes:Array = new Array();
				nodes.push(new Point(x.@x, x.@y));
				
				for each (var y:XML in x.children())
					nodes.push(new Point(y.@x, y.@y));
				
				add(new Enemy(x.@x, x.@y, nodes, new EnemyHitBox()));
			}
		}
		
	}

}