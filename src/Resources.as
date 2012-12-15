package  
{
    import net.flashpunk.Sfx;
    import flash.utils.Dictionary;
    
    public class Resources 
    {
        [Embed(source = "data/graphics/box.png")] static public const IMG_BOX:Class;
        [Embed(source = "data/graphics/efx_abduct.png")] static public const IMG_EFX_ABDUCT:Class;
        [Embed(source = "data/graphics/person.png")] static public const IMG_PERSON:Class;
        [Embed(source = "data/graphics/tileset.png")] static public const IMG_TILESET:Class;
        [Embed(source = "data/graphics/ufo.png")] static public const IMG_UFO:Class;
        [Embed(source = "data/levels/testlevel.oel", mimeType = "application/octet-stream")] static public const LVL_TESTLEVEL:Class;
        
        static private var _levelDictionary:Dictionary;

        public function Resources() 
        {
            
        }
        
        static public function init():void
        {
            _levelDictionary = new Dictionary();
            _levelDictionary["testlevel"] = LVL_TESTLEVEL;
        }
        
        static public function getLevelFromString(s:String):Class
        {
            return _levelDictionary[s];
        }
        
    }

}