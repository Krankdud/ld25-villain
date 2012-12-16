package  
{
	import flash.utils.Dictionary;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Tilemap;
	import net.flashpunk.masks.Grid;
	import net.flashpunk.masks.Hitbox;
	import net.flashpunk.World;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;

	public class GameWorld extends World
	{
		
		public function GameWorld() 
		{
			super();
			
			FP.screen.color = 0xd7eb96;
			Global.goalCurrent = 0;
			
			Global.particleManager = new ParticleManager();
			
			loadLevel(Global.nextLevel);
			add(Global.particleManager);
			add(new Hud());
		}
		
		override public function update():void
		{
			Global.camera.update();
			
			if (Input.pressed(Key.R))
			{
				Global.nextLevel = Global.currentLevel;
				FP.world = new IntermissionWorld();
			}
			
			if (Global.goalCurrent >= Global.goalAmount)
				FP.world = new IntermissionWorld();
			
			super.update();
		}
		
		public function loadLevel(level:String):void
		{
			var xml:XML = new XML(new (Resources.getLevelFromString(level)));
			
			Global.levelWidth = xml.@width;
			Global.levelHeight = xml.@height;
			
			Global.currentLevel = Global.nextLevel;
			Global.nextLevel = xml.@nextLevel;
			var s:String = xml.@mission;
			switch (s)
			{
				case "abduct":
					Global.goalType = Global.GOAL_ABDUCT;
					break;
				case "squish":
					Global.goalType = Global.GOAL_SQUISH;
					break;
				case "goats":
					Global.goalType = Global.GOAL_GOATS;
					break;
			}
			Global.goalAmount = xml.@goal;
			
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
			
			if (xml.entities.elements("goat").length() > 0)
			{
				for each (o in xml.entities.goat)
				{
					add(new Goat(o.@x, o.@y));
				}
			}
			
			if (xml.entities.elements("bat").length() > 0)
			{
				for each (o in xml.entities.bat)
				{
					add(new Bat(o.@x, o.@y));
				}
			}
			
			if (xml.entities.elements("turret").length() > 0)
			{
				for each (o in xml.entities.turret)
				{
					add(new Turret(o.@x, o.@y));
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