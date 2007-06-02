import com.bourre.events.IEvent;
import com.bourre.log.PixlibStringifier;

import Picasa.Photo;
import Picasa.Service;
import Picasa.tools.Map2;
import Picasa.tools.ObjectIterator2;

/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
 
class Picasa.PhotoService extends Service
{
	private var __map:Map2;
	private var __current:String;
	private var __old:String;
	private var __it:ObjectIterator2;
	
	public var onPhotoServiceEvent:Function;
	/**
	 * Constructor
	 */
	public function PhotoService(aParent:Object)
	{
		super();
		
		__current = null;
		__old = null;
	}
	/**
	 * 
	 */
	public function addPhoto(aPhoto:Photo,aSetCurrent:Boolean):Void
	{
		var tID:String = aPhoto.getIdString();
		
		if(tID != null)
		{
			if(!contains(tID))
			{
				__map.put(tID,aPhoto);
				
				if(aSetCurrent) { 
					setCurrent(tID);
				}
			} else
			{
				trace("Photo "+tID+" already added!", Log.WARNING)
			}
		} else
		{
			trace("Photo has null id!", Log.ERROR);
		}
	}
	/**
	 * 
	 */
	public function removePhoto(aPhoto:Photo):Void
	{
		var tID:String = aPhoto.getIdString();
		if (tID != null)
		{
			if (contains(tID))
			{
				__map.remove(tID);
			}
			else
			{
				trace("Album "+tID+" is not available!",Log.WARNING);
			}
		}
		else
		{
			trace("Album id is null!",Log.ERROR);
		}
	}
	/**
	 * 
	 */
	public function getCurrentPhoto():Photo
	{
		return getPhoto(__current);
	}
	/**
	 * 
	 */
	public function setCurrent(aID:String):Void
	{
		__current = aID;
		__it.setIndex(__it.searchKey(aID));
	}
	/**
	 * 
	 */
	public function getCurrent():String
	{
		return __current;
	}
	/**
	 * 
	 */
	public function getPhoto(aID:String):Photo
	{
		if(!contains(aID)) {
			trace("Photo "+aID+" is not available!",Log.ERROR);
		}
		
		setCurrent(aID);
		
		return __map.get(aID);
	}
	/**
	 * 
	 */
	public function getPhotos():Void
	{
	}
	/**
	 * 
	 */
	public function getNextPhoto():Photo
	{	
		if(!__it.hasNext()) {
			reset();
		}

		return getPhoto(__it.next());
	}
	/**
	 * 
	 */
	public function getPrevPhoto():Photo
	{	
		if(!__it.hasPrev()) {
			__it.seek(size()+1);
		}
		
		return getPhoto(__it.prev());
	}
	/**
	 * 
	 */
	public function getAlbumId():String
	{
		return getCurrentPhoto().getAlbumId();
	}
	/**
	 * 
	 */
	public function clear():Void
	{
		__map.clear();
		__current = null;
		
		reset();
	}
	/**
	 * 
	 */
	public function reset():Void
	{
		if(size() > 0)
		{
			__it = __map.getKeysIterator();
		}
		else
		{
			__it = null ;
		}
	}
	/**
	 * 
	 */
	public function size():Number
	{
		return __map.getSize();
	}
	/**
	 * 
	 */
	public function contains(aID:String):Boolean
	{
		return __map.containsKey(aID);
	}
	/**
	 * Called when successfuly loaded xml
	 */
	private function onInitialize(e:IEvent):Void 
	{
		if(__map != undefined) return;
		
		__map = new Map2();
		
		var tData = getData();
		var tEntries = tData.entry;
		
		for(var a = 0; a < tEntries.length; a++)
		{
			addPhoto(new Photo(tEntries[a]),(a == 0));
		}
		
		reset();
		notifyChanged(e);
	}
	
	private function notifyChanged(e:IEvent):Void
	{
		onPhotoServiceEvent(e);
	}
	/**
	 * 
	 */
	private function onFileProgress(e:IEvent):Void
	{
	}
	/**
	 * 
	 */
	private function onFileTimeout(e:IEvent):Void
	{
	}
	/**
	 * 
	 */
	private function onFileError(e:IEvent):Void
	{
		trace("com.kvenda.services.PhotoService.onFileError("+e+")");
	}

	public function toString():String
	{
		return PixlibStringifier.stringify(this);
	}
}