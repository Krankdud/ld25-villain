package  
{
	import net.flashpunk.FP;
	import net.flashpunk.World;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;

	public class IntermissionWorld extends World
	{
		private const SHOW_TEXT1:int = 60;
		private const SHOW_TEXT2:int = 120;
		private const SHOW_TEXT3:int = 240;
		
		private var _timer:int;
		private var _t1:Text;
		private var _t2:Text;
		private var _t3:Text;
		
		public function IntermissionWorld() 
		{
			super();
			
			FP.screen.color = 0x204530;
			
			var xml:XML = new XML(new (Resources.getLevelFromString(Global.nextLevel)));
			
			var o:Object = new Object;
			o.size = 16;
			o.align = "center";
			o.width = FP.width;
			o.color = 0xd7eb96;
			
			var s:String;
			s = xml.@name;
			_t1 = new Text(s, 0, 64, o);
			s = xml.@mission;
			switch (s)
			{
				case "abduct":
					s = "Abduct " + xml.@goal;
					if (xml.@goal == 1)
						s += " person!";
					else
						s += " people!";
					break;
				case "squish":
					s = "Squish " + xml.@goal;
					if (xml.@goal == 1)
						s += " person!";
					else
						s += " people!";
					break;
				case "goats":
					s = "Abduct " + xml.@goal;
					if (xml.@goal == 1)
						s += " goat!";
					else
						s += " goats!";
					break;
			}
			_t2 = new Text(s, 0, 96, o);
			_t3 = new Text("Press X to Continue", 0, 192, o);
		}
		
		override public function update():void 
		{
			if (_timer < 400)
				_timer++;
			if (_timer == SHOW_TEXT1)
				addGraphic(_t1);
			if (_timer == SHOW_TEXT2)
				addGraphic(_t2);
			if (_timer == SHOW_TEXT3)
				addGraphic(_t3);
			
			if (Input.pressed(Key.X) && _timer > 180)
				FP.world = new GameWorld();
			
			super.update();
		}
		
	}

}