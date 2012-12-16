package  
{
	import net.flashpunk.FP;
	import net.flashpunk.World;
	import net.flashpunk.graphics.Stamp;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;

	public class EndWorld extends World
	{
		private const TIME_TEXT1:int = 90;
		private const TIME_TEXT2:int = 390;
		
		private var _timer:int;
		
		private var _t1:Text;
		private var _t2:Text;
		
		public function EndWorld() 
		{
			super();
			
			FP.screen.color = 0x204530;
			addGraphic(new Stamp(Resources.IMG_END));
			
			_timer = 0;
			
			var o:Object = new Object;
			o.size = 16;
			o.align = "center";
			o.width = FP.width;
			o.color = 0xd7eb96;
			_t1 = new Text("Congratulations!\nYou have taken all\nthe people and goats!", 0, 16, o);
			_t1.visible = false;
			addGraphic(_t1);
			
			o.color = 0x204530;
			o.size = 16;
			_t2 = new Text("Press X to Restart", 0, 208, o);
			_t2.visible = false;
			addGraphic(_t2);
		}
		
		override public function update():void
		{
			if (_timer < 500)
				_timer++;
			
			if (_timer == TIME_TEXT1)
			{
				_t1.visible = true;
				Resources.sfxIntermission.play();
			}
			else if (_timer == TIME_TEXT2)
				_t2.visible = true;
				
			if (Input.pressed(Key.X) && _timer >= 400)
				FP.world = new MenuWorld();
			
			super.update();
		}
		
	}

}