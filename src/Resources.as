package  
{
    import net.flashpunk.Sfx;
    import flash.utils.Dictionary;
    
    public class Resources 
    {
        [Embed(source = "data/graphics/bars.png")] static public const IMG_BARS:Class;
        [Embed(source = "data/graphics/bat.png")] static public const IMG_BAT:Class;
        [Embed(source = "data/graphics/box.png")] static public const IMG_BOX:Class;
        [Embed(source = "data/graphics/button.png")] static public const IMG_BUTTON:Class;
        [Embed(source = "data/graphics/efx_abduct.png")] static public const IMG_EFX_ABDUCT:Class;
        [Embed(source = "data/graphics/person.png")] static public const IMG_PERSON:Class;
        [Embed(source = "data/graphics/tileset.png")] static public const IMG_TILESET:Class;
        [Embed(source = "data/graphics/ufo.png")] static public const IMG_UFO:Class;
        [Embed(source = "data/levels/testlevel.oel", mimeType = "application/octet-stream")] static public const LVL_TESTLEVEL:Class;
        [Embed(source = "data/levels/testlevel2.oel", mimeType = "application/octet-stream")] static public const LVL_TESTLEVEL2:Class;
        
        static private var _levelDictionary:Dictionary;

        public function Resources() 
        {
            
        }
        
        static public function init():void
        {
            _levelDictionary = new Dictionary();
            _levelDictionary["testlevel"] = LVL_TESTLEVEL;
            _levelDictionary["testlevel2"] = LVL_TESTLEVEL2;
        }
        
        static public function getLevelFromString(s:String):Class
        {
            return _levelDictionary[s];
        }
        
    }

}