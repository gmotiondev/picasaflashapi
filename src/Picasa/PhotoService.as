import com.bourre.events.IEvent;
import com.bourre.log.PixlibStringifier;
import com.bourre.data.libs.LibEvent;

import Picasa.Photo;
import Picasa.Service;import Picasa.IService;
import Picasa.tools.Map2;
//import Picasa.tools.ObjectIterator2;

/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
 
class Picasa.PhotoService extends Service implements IService
{
	/**
	 * Constructor
	 */
	public function PhotoService(aParent:Object)
	{
		super();
		
		__current = null;
	}
	/**
	 * Adds a Picasa.Photo object to Map.
	 * @param aPhoto Picasa.Photo object
	 * @param aSetCurrent Boolean, if true, sets as current id.
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
	 * Removes Picasa.Photo object from Map.
	 * @param aPhoto Picasa.Photo object to be removed.
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
	 * Returns current Picasa.Photo
	 * @return Current Picasa.Photo object.
	 */
	public function getCurrentPhoto():Photo
	{
		return getPhoto(__current);
	}
	/**
	 * Sets a Picasa.Photo id as a current id.
	 * @param aID String, Picasa.Photo id.
	 */
	public function setCurrent(aID:String):Void
	{
		__current = aID;
		__it.setIndex(__it.searchKey(aID));
	}
	/**
	 * Returns current photo id(key).
	 * @return String, current photo id.
	 */
	public function getCurrent():String
	{
		return __current;
	}
	/**
	 * Returns Picasa.Photo object with specified ID.
	 * @param aID String, Picasa.Photo id.
	 * @return Picasa.Photo object with specified ID.
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
	 * Returns a Map2 object with Picasa.Photo objects.
	 * @return Map2 object with Picasa.Photo objects.
	 */
	public function getPhotos():Map2
	{
		return __map;
	}
	/**
	 * Returns Picasa Photos count.
	 * @return Picasa Photos count.	 */
	public function getPhotosCount():Number
	{
		return size();
	}
	/**
	 * Get next photo from current photo.
	 * @return Next Picasa.Photo object in the map.
	 */
	public function getNextPhoto():Photo
	{	
		if(!__it.hasNext()) {
			reset();
		}

		return getPhoto(__it.next());
	}
	/**
	 * Get previous photo from current photo.
	 * @return Previous Picasa.Photo object in the map.
	 */
	public function getPrevPhoto():Photo
	{	
		if(!__it.hasPrev()) {
			__it.seek(size()+1);
		}
		
		return getPhoto(__it.prev());
	}
	/**
	 * Get album ID.
	 * @return ID of the album in which the photo is stored. (album of the photo, parent...)
	 */
	public function getAlbumId():String
	{
		return getCurrentPhoto().getAlbumId();
	}
	/**
	 * Called when successfuly loaded xml
	 */
	public function onInitialize(e:LibEvent):Void 
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
	/**
	 * Called after onInitialize is invoked.
	 * @param e LibEvent event.	 */
	public function notifyChanged(e:IEvent):Void
	{
		onServiceLoaded(e);
	}
	/**
	 * Event sent, during xml loading.
	 * @param e LibEvent event.
	 */
	public function onFileProgress(e:LibEvent):Void
	{
		trace("Picasa.PhotoService.onFileProgress("+e.getPerCent()+"% loaded from "+e.getLib().getURL()+")",Log.INFO);
	}
	/**
	 * If xml loading timed out.
	 * @param e LibEvent event.
	 */
	public function onFileTimeout(e:LibEvent):Void
	{
		trace("Picasa.PhotoService.onFileTimeout("+e+")",Log.ERROR);
	}
	/**
	 * If xml loading failed.
	 * @param e LibEvent event.
	 */
	public function onFileError(e:LibEvent):Void
	{
		trace("Picasa.PhotoService.onFileError("+e+")",Log.ERROR);
	}

	public function toString():String
	{
		return PixlibStringifier.stringify(this);
	}
}