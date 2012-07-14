package Entities 
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Text;
	
	/**
	 * ...
	 * @author Haggis
	 */
	public class DialogBox extends Entity 
	{
		private var text:Text = new Text("", 0, 0, 450, 150);
		private var offsetX:Number = 150;
		private var offsetY:Number = 400;
		private var background:Image;
		private var timer:Number;
		public function DialogBox(score:Boolean = false, ofX:Number = 0, ofY:Number = 0, t:Number = -1337) 
		{
			
			var g:Graphiclist = new Graphiclist();
			if (ofX != 0)
				offsetX = ofX;
			if (ofY != 0)
				offsetY = ofY;
			timer = t;
			if (!score) {
				background = new Image(Assets.PLAY_BUTTON_HOVER)
				background.alpha = 0.3;
				background.x = -20;
				background.y = -background.height / 2;
				background.visible = false;
				g.add(background);
				
			}
			g.add(text);
			super(x, y, g);
		}
		
		public function setText(txt:String, t:Number = -1337, overwrite:Boolean=false):void {
			if(timer == -1337 || overwrite) {
				text.text = txt;
				timer = t;
			}
		}
		
		
		
		override public function update():void
		{
			x = FP.camera.x + offsetX;
			y = FP.camera.y + offsetY;
			if (timer != -1337) {
				timer -= FP.elapsed;
				if (timer < 0) {
					timer = -1337;
					text.text = "";
				}
			}
			super.update();
		}
	}

}