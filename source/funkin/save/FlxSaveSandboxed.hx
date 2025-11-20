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
  static final SAVE_PATH:String = 'FunkinCrew';
  static final SAVE_NAME:String = 'Funkin';
  static final BASE_SAVE_SLOT:Int = 1;

  public function new()
  {
    super();
  }
  
	override public function bind(name:String, ?path:String, ?backupParser:(String, Exception)->Null<Any>):Bool
  {
    if (name == '$SAVE_NAME${BASE_SAVE_SLOT}' && path == null) throw 'Unable to bind to $name. Use funkin.save.Save instead.';
    return super.bind(name, '$SAVE_PATH${path != null ? '/$path' : ''}', backupParser);
  }

  override public function mergeDataFrom(name:String, ?path:String, overwrite = false, eraseSave = true, minFileSize = 0):Bool
  {
    if (name == '$SAVE_NAME${BASE_SAVE_SLOT}' && path == null) throw 'Unable to merge save. Requested save data cannot be a Funkin save.';
    return super.mergeDataFrom(name, '$SAVE_PATH${path != null ? '/$path' : ''}', overwrite, false, minFileSize);
  }  

  @:unreflective
  override public function erase():Bool
  {
    if (this.name == '$SAVE_NAME${BASE_SAVE_SLOT}' && this.path == SAVE_PATH) throw 'Unable to delete ${this.name} because it\'s a Funkin save.';
    return super.erase();
  }  
}