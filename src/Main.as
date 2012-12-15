package 
{
	import net.flashpunk.Engine;
	import net.flashpunk.FP;
	
	public class Main extends Engine
	{
		
		public function Main()
		{
			super(320, 240, 60, true);
			
			Resources.init();
			
			FP.screen.scale = 2;
			FP.world = new GameWorld();
		}
		
	}
	
}