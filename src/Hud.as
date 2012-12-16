package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Text;

	public class Hud extends Entity
	{
		private var _text:Text;
		
		public function Hud() 
		{
			super();
			
			var o:Object = new Object;
			o.size = 16;
			o.color = 0xaec741;
			_text = new Text("Abducted: 100/100", 4, 4, o);
			graphic = _text;
			
			layer = -100;
		}
		
		override public function update():void
		{
			_text.x = FP.camera.x + 2;
			_text.y = FP.camera.y + 2;
			if (Global.goalType == Global.GOAL_ABDUCT || Global.goalType == Global.GOAL_GOATS)
				_text.text = "Abducted: " + Global.goalCurrent.toString() + "/" + Global.goalAmount.toString();
			if (Global.goalType == Global.GOAL_SQUISH)
				_text.text = "Squished: " + Global.goalCurrent.toString() + "/" + Global.goalAmount.toString();
		}
		
	}

}