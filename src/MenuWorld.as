package  
{
	import net.flashpunk.FP;
	import net.flashpunk.World;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;

	public class MenuWorld extends World
	{
		
		public function MenuWorld() 
		{
			super();
			
			FP.screen.color = 0x204530;
			
			Global.nextLevel = "testlevel";
			
			var o:Object = new Object();
			o.size = 24;
			o.align = "center";
			o.width = FP.width;
			o.color = 0xd7eb96;
			addGraphic(new Text("Some UFO Game", 0, 32, o));
			
			o.size = 16;
			addGraphic(new Text("Press X to Start", 0, 160, o));
		}
		
		override public function update():void
		{
			if (Input.pressed(Key.X))
			{
				FP.world = new IntermissionWorld();
			}
		}
		
	}

}