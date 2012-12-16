package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.graphics.Graphiclist;

	public class Hud extends Entity
	{
		private var _text:Text;
		private var _pause:Text;
		private var _success:Text;
		private var _impossible:Text;
		
		public function Hud() 
		{
			super();
			
			var o:Object = new Object();
			o.size = 16;
			o.color = 0xaec741;
			_text = new Text("Abducted: 100/100", 4, 4, o);
			
			o.width = FP.width;
			o.align = "center";
			_pause = new Text("Pause", 0, 96, o);
			_pause.visible = false;
			
			_success = new Text("Success!", 0, 96, o);
			_success.visible = false;
			
			_impossible = new Text("Press R to Restart", 0, 208, o);
			_impossible.visible = false;
			
			graphic = new Graphiclist(_text, _pause, _success, _impossible);
			
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
				
			if (Global.paused)
			{
				_pause.visible = true;
				_pause.x = FP.camera.x;
				_pause.y = FP.camera.y + 96;
			}
			else
			{
				_pause.visible = false;
			}
			
			if (Global.levelFinished)
			{
				_success.x = FP.camera.x;
				_success.y = FP.camera.y + 96;
				_success.visible = true;
			}
			
			if (Global.levelImpossible)
			{
				_impossible.x = FP.camera.x;
				_impossible.y = FP.camera.y + 208;
				_impossible.visible = true;
			}
		}
		
	}

}