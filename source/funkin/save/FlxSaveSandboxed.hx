package funkin.save;

import flixel.util.FlxSave;
import haxe.Exception;

/**
 * Wrapper for `FlxSave`
 * Prevents the use of `resolveFlixelClasses` function
 * Also locks down saves to only save inside the `FunkinCrew` folder
 */
@:nullSafety
class FlxSaveSandboxed extends FlxSave
{
  public function new()
  {
    super();
  }
  
	override public function bind(name:String, ?path:String, ?backupParser:(String, Exception)->Null<Any>):Bool
  {
    if (name == Constants.SAVE_NAME + Constants.BASE_SAVE_SLOT && path == null) throw 'Unable to bind to $name. Use funkin.save.Save instead.';
    return super.bind(name, Constants.SAVE_PATH + (path != null ? '/$path' : ''), backupParser);
  }

  override public function mergeDataFrom(name:String, ?path:String, overwrite = false, eraseSave = true, minFileSize = 0):Bool
  {
    if (name == Constants.SAVE_NAME + Constants.BASE_SAVE_SLOT && path == null) throw 'Unable to merge from a Funkin save.';
    return super.mergeDataFrom(name, Constants.SAVE_PATH + (path != null ? '/$path' : ''), overwrite, false, minFileSize);
  }  

  @:unreflective
  override public function erase():Bool
  {
    if (this.name == Constants.SAVE_NAME + Constants.BASE_SAVE_SLOT && this.path == Constants.SAVE_PATH) throw 'Unable to delete ${this.name}.';
    return super.erase();
  }  
}