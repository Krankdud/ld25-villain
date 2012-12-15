package  
{
	import flash.utils.Dictionary;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Tilemap;
	import net.flashpunk.masks.Grid;
	import net.flashpunk.masks.Hitbox;
	import net.flashpunk.World;

	public class GameWorld extends World
	{
		
		public function GameWorld() 
		{
			super();
			
			FP.screen.color = 0xd7eb96;
			
			loadLevel(Global.nextLevel);
		}
		
		override public function update():void
		{
			Global.camera.update();
			
			super.update();
		}
		
		public function loadLevel(level:String):void
		{
			var xml:XML = new XML(new (Resources.getLevelFromString(level)));
			
			Global.levelWidth = xml.@width;
			Global.levelHeight = xml.@height;
			
			Global.nextLevel = xml.@nextLevel;
			
			var grid:Grid = new Grid(xml.@width, xml.@height, 16, 16);
			grid.usePositions = true;
			var tilemap:Tilemap = new Tilemap(Resources.IMG_TILESET, xml.@width, xml.@height, 16, 16);
			
			for each (var o:XML in xml.mask.rect)
			{
				grid.setRect(o.@x, o.@y, o.@w, o.@h);
			}
			
			for each (o in xml.tileset.tile)
			{
				tilemap.setTile(o.@x, o.@y, o.@id);
			}
			
			addMask(grid, "solid");
			addGraphic(tilemap, 1000);
			
			if (xml.entities.elements("player").length() > 0)
			{
				Global.player = new Player(xml.entities.player.@x, xml.entities.player.@y);
				Global.camera.follow = Global.player;
				add(Global.player);
			}
			
			if (xml.entities.elements("box").length() > 0)
			{
				for each (o in xml.entities.box)
				{
					add(new Box(o.@x, o.@y));
				}
			}
			
			if (xml.entities.elements("person").length() > 0)
			{
				for each (o in xml.entities.person)
				{
					add(new Person(o.@x, o.@y));
				}
			}
			
			if (xml.entities.elements("bat").length() > 0)
			{
				for each (o in xml.entities.bat)
				{
					add(new Bat(o.@x, o.@y));
				}
			}
			
			if (xml.entities.elements("hurt").length() > 0)
			{
				for each (o in xml.entities.hurt)
				{
					addMask(new Hitbox(o.@width, o.@height), "enemy", o.@x, o.@y);
				}
			}
			
			// Triggered stuff
			var trigger:Array = new Array();
			
			if (xml.entities.elements("bars").length() > 0)
			{
				for each (o in xml.entities.bars)
				{
					trigger[o.@triggerid] = new Bars(o.@x, o.@y, o.@height);
					add(trigger[o.@triggerid]);
				}
			}
			
			if (xml.entities.elements("button").length() > 0)
			{
				for each (o in xml.entities.button)
				{
					var b:Button = new Button(o.@x, o.@y);
					b.setTarget(trigger[o.@triggerid]);
					add(b);
				}
			}
		}
		
	}

}