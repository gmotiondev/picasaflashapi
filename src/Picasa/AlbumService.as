import com.bourre.events.IEvent;
import com.bourre.log.PixlibStringifier;
import com.bourre.data.libs.LibEvent;

import Picasa.Photo;
import Picasa.Service;
import Picasa.IService;
import Picasa.tools.Map2;

/**
 * @author Michal Gron (michal.gron@gmail.com)
 */

/**
 * get xml photo header, before entries ... 
 */
class Picasa.AlbumService extends Service implements IService
//class Picasa.AlbumService extends Picasa.JSONService implements IService
{
	/**
	 * Constructor
	 */
	public function AlbumService(aUrl:String,aAlbumId)
	{
		super(aUrl+"/albumid/"+aAlbumId,"photo");	//ugly!!
		iterator = null;
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
				map.put(tID,aPhoto);

				if(aSetCurrent) { 
					setCurrent(tID);
				}
			} else
			{
				trace("Photo "+tID+" already added!")
			}
		} else
		{
			trace("Photo has null id!");
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
				map.remove(tID);
			}
			else
			{
				trace("WARN: Album "+tID+" is not available!");
			}
		}
		else
		{
			trace("ERROR: Album id is null!");
		}
	}
	/**
	 * Returns current Picasa.Photo
	 * @return Current Picasa.Photo object.
	 */
	public function getCurrentPhoto():Photo
	{
		return getPhoto(current);
	}
	/**
	 * Sets a Picasa.Photo id as a current id.
	 * @param aID String, Picasa.Photo id.
	 */
	public function setCurrent(aID:String):Void
	{
		current = aID;
		iterator.setIndex(iterator.searchKey(aID));
	}
	/**
	 * Returns current photo id(key).
	 * @return String, current photo id.
	 */
	public function getCurrent():String
	{
		return current;
	}
	public function getCurrentIndex():Number
	{
		return iterator.getIndex();
	}
	/**
	 * Returns Picasa.Photo object with specified ID.
	 * @param aID String, Picasa.Photo id.
	 * @return Picasa.Photo object with specified ID.
	 */
	public function getPhoto(aID:String):Photo
	{
		if(!contains(aID)) {
			trace("Photo "+aID+" is not available!");
		}
		
		setCurrent(aID);
		
		return map.get(aID);
	}
	/**
	 * Returns a Map2 object with Picasa.Photo objects.
	 * @return Map2 object with Picasa.Photo objects.
	 */
	public function getPhotos():Map2
	{
		return map;
	}
	/**
	 * Returns Picasa Photos count.
	 * @return Picasa Photos count.
	 */
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
		if(!iterator.hasNext()) {
			reset();
		}

		return getPhoto(iterator.next());
	}
	/**
	 * Get previous photo from current photo.
	 * @return Previous Picasa.Photo object in the map.
	 */
	public function getPrevPhoto():Photo
	{	
		if(!iterator.hasPrev()) {
			iterator.seek(size()+1);
		}
		
		return getPhoto(iterator.prev());
	}
	/**
	 * Get first photo.
	 * 
	 */
	public function getFirstPhoto():Photo
	{	
		reset();
		return getPhoto(iterator.next());
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
		if(map != undefined) return;
		
		map = new Map2();
		
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
	 * @param e LibEvent event.
	 */
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
		//trace("Picasa.AlbumService.onFileProgress("+e.getPerCent()+"% loaded from "+e.getLib().getURL()+")",Log.INFO);
	}
	/**
	 * If xml loading timed out.
	 * @param e LibEvent event.
	 */
	public function onFileTimeout(e:LibEvent):Void
	{
		trace("ERROR: Picasa.AlbumService.onFileTimeout("+e+")");
	}
	/**
	 * If xml loading failed.
	 * @param e LibEvent event.
	 */
	public function onFileError(e:LibEvent):Void
	{
		trace("ERROR: Picasa.AlbumService.onFileError("+e+")");
	}

	public function toString():String
	{
		return PixlibStringifier.stringify(this);
	}
}