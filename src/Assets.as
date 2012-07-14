package  
{
	import flash.geom.Point;
	/**
	 * ...
	 * @author Haggis
	 */
	public class Assets 
	{
		[Embed(source='../assets/gfx/menu.png')]
		public static const MAIN_MENU:Class
		
		[Embed(source = '../assets/gfx/maptiles.png')]
		public static const TILE_SHEET:Class;
		
		[Embed(source = '../assets/gfx/baseTiles.png')]
		public static const BASE_SHEET:Class;
		
		[Embed(source='../assets/levels/LevelZero.oel', mimeType='application/octet-stream')]
		public static const LEVEL0:Class;
		
		[Embed(source='../assets/levels/LevelOne.oel', mimeType='application/octet-stream')]
		public static const LEVEL1:Class;
		
		[Embed(source='../assets/levels/LevelTwo.oel', mimeType='application/octet-stream')]
		public static const LEVEL2:Class;
		
		[Embed(source = '../assets/levels/LevelThree.oel', mimeType = 'application/octet-stream')]
		public static const LEVEL3:Class;
		
		[Embed(source='../assets/levels/LevelFour.oel', mimeType='application/octet-stream')]
		public static const LEVEL4:Class;
		
		[Embed(source='../assets/levels/LevelFive.oel', mimeType='application/octet-stream')]
		public static const LEVEL5:Class;
		
		[Embed(source='../assets/levels/LevelSeven.oel', mimeType='application/octet-stream')]
		public static const LEVEL7:Class;
		
		[Embed(source='../assets/levels/LevelTwoOne.oel', mimeType='application/octet-stream')]
		public static const LEVEL21:Class;
		
		[Embed(source = '../assets/levels/LevelTwoTwo.oel', mimeType = 'application/octet-stream')]
		public static const LEVEL22:Class;
		
		[Embed(source = '../assets/levels/LevelTwoThree.oel', mimeType = 'application/octet-stream')]
		public static const LEVEL23:Class;
		[Embed(source='../assets/gfx/door_placeholder.png')]
		public static const DOOR_0:Class
		
		[Embed(source='../assets/gfx/door_placeholder.png')]
		public static const DOOR_1:Class
		
		[Embed(source = '../assets/gfx/Characters/MainCharacter/Main_Char_Sprites.png')]
		public static const PLAYER_SPRITE:Class;
		
		[Embed(source='../assets/gfx/characters/Guards/Guard_Sprites.png')]
		public static const ENEMY_SPRITE_SHEET:Class;
		
		[Embed(source='../assets/gfx/enemy_fov.PNG')]
		public static const ENEMY_FOV:Class;
		
		[Embed(source='../assets/gfx/playButton.PNG')]
		public static const PLAY_BUTTON_NORMAL:Class;
		
		[Embed(source='../assets/gfx/playButtonHover.PNG')]
		public static const PLAY_BUTTON_HOVER:Class;
		
		[Embed(source='../assets/gfx/playButtonDown.PNG')]
		public static const PLAY_BUTTON_DOWN:Class;
		
		[Embed(source='../assets/gfx/page1.png')]
		public static const STORY_0:Class;
		
		[Embed(source = '../assets/gfx/diarypages/Diary2.png')]
		public static const STORY_1:Class;
		
		[Embed(source = '../assets/gfx/diarypages/Diary3.png')]
		public static const STORY_2:Class;
		
		[Embed(source = '../assets/gfx/diarypages/Diary4.png')]
		public static const STORY_3:Class;
		
		[Embed(source = '../assets/gfx/diarypages/Diary5.png')]
		public static const STORY_4:Class;
		
		[Embed(source = '../assets/gfx/diarypages/Diary6.png')]
		public static const STORY_5:Class;
		
		[Embed(source = '../assets/gfx/diarypages/Diary7.png')]
		public static const STORY_6:Class;
		
		[Embed(source = '../assets/gfx/enemy_fov1.png')]
		public static const ENEMY_FOV1:Class
		
		[Embed(source = '../assets/gfx/enemy_fov2.PNG')]
		public static const ENEMY_FOV2:Class
		
		[Embed(source = '../assets/gfx/enemy_fov3.png')]
		public static const ENEMY_FOV3:Class
		
		[Embed(source='../assets/gfx/Characters/Baker/Bakerspritesheet.png')]
		public static const BAKER_SHEET:Class
		
		[Embed(source='../assets/gfx/Characters/Chemist/Chemistss.png')]
		public static const DOCTOR_SHEET:Class
		
		[Embed(source='../assets/gfx/Characters/Brother/BrotherLeft1.png')]
		public static const BROTHER:Class
		
		[Embed(source = '../assets/gfx/Characters/Brother/Brother_Right1.png')]
		public static const BROTHER1:Class
		
		[Embed(source = '../assets/gfx/Characters/Granny/Granny_Sprites.png')]
		public static const GRAN_SPRITE:Class
		
		[Embed(source='../assets/gfx/Characters/Civilian1/Civillian1ss.png')]
		public static const CIV_1:Class
		
		[Embed(source='../assets/gfx/Characters/Civilian2/Civilian2ss.png')]
		public static const CIV_2:Class
		
		[Embed(source='../assets/gfx/Characters/Bread/Breadleft.png')]
		public static const BREAD:Class
		
		[Embed(source='../assets/gfx/Characters/Medicine/Medicineleft.png')]
		public static const MEDICINE:Class
		
		public static const LEVEL_ARRAY:Array = new Array(LEVEL0, LEVEL1, LEVEL2, LEVEL21, LEVEL3, LEVEL22, LEVEL4, LEVEL5, LEVEL23, LEVEL7);
		public static const LEVEL_TILES_ARRAY:Array = new Array(0, 1, 0, 0, 1, 0,1,0,0,1);
		public static const LEVEL_CONSTRANINTS_ARRAY:Array = new Array(0, 1, 0, 0, 1, 0,1,0,0,0);
		public static const LEVEL_STORY_ARRAY:Array = new Array(0,1,1,0,1,0,1,1,1,0);
		
		public static const STORY_ARRAY:Array = new Array(STORY_0, STORY_1, STORY_2, STORY_3, STORY_4, STORY_5, STORY_6);
		
		public static const ENEMY_FOV_ARRAY:Array = new Array(ENEMY_FOV, ENEMY_FOV1, ENEMY_FOV2, ENEMY_FOV3);
		
		public static const RAIL_MOVEMENT_ARRAY:Array = new Array(BAKER_SHEET, DOCTOR_SHEET, CIV_1, CIV_2, GRAN_SPRITE);
		
		public static const OBJECT_ARRAY:Array = new Array(BREAD, MEDICINE, BROTHER);
	}

}