package  
{
	import Entities.DialogBox;
	import Entities.Player;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import org.flashdevelop.utils.FlashViewer;
	import Worlds.*;
	/**
	 * ...
	 * @author Haggis
	 */
	public class Global 
	{
		public static var DAY:int = 1;
		public static var INSIDE:Boolean = true;
		public static var CUR_LEVEL:int =-1; 
		public static const GRID_SIZE:uint = 40;
		public static var PLAYER:Player;
		public static var VIEW:View;
		public static var GAME:Game;
		public static var STORY:Story;
		public static var DIALOG_BOX:DialogBox;
		public static const GAME_TIMER_ARRAY:Array = new Array( -1337, -1337, -1337, -1337, -1337, -1337, -1337, -1337, 10, -1337, -1337);
		public static var TIME_LEFT:DialogBox;
		public static const ENEMY_FOV_OFFSET_ARRAY:Array = new Array(new Point(-90, -270), new Point(-63,-100), new Point(-112,-25), new Point(-250,-80));
		public static const ENEMY_HIT_BOX:Rectangle = new Rectangle(0, 0, 15, 30);
		public static var NEXT_STORY:int = 0;
		public static var NEXT_LEVEL:int = 0;
		public static const LEVEL_HAS_OBJECT:Array = new Array(false, true, false, true, true, true, false, false, false, false);
	}

}