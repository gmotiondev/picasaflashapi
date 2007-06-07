import com.bourre.events.IEvent;
import com.bourre.log.PixlibStringifier;
import com.bourre.data.libs.LibEvent;

import Picasa.Album;
import Picasa.Service;import Picasa.IService;
import Picasa.tools.Map2;

/**
 * @author Michal Gron (michal.gron@gmail.com)
 */

/**
 * TODO:
 * get xml header infos, before entries (album cover, ...)
 * authKey for unlisted albums? */
class Picasa.AlbumService extends Service implements IService
{
	/**
	 * Constructor
	 */
	public function AlbumService(aParent:Object)
	{
		super();
		
		current = null;
	}
	/**
	 * Adds a Picasa.Album object to Map.
	 * @param aAlbum Picasa.Album object.
	 * @param aSetCurrent Boolean, if true, sets as current id.
	 */
	public function addAlbum(aAlbum:Album,aSetCurrent:Boolean):Void
	{
		var tID:String = aAlbum.getIdString();
		
		if(tID != null)
		{
			if(!contains(tID))
			{
				map.put(tID,aAlbum);
				
				if(aSetCurrent) { 
					setCurrent(tID);
				}
			} else
			{
				trace("Album "+tID+" already added!", Log.WARNING)
			}
		} else
		{
			trace("Album has null id!", Log.ERROR);
		}
	}
	/**
	 * Removes Picasa.Album object from Map.
	 * @param aAlbum Picasa.Album object to be removed.
	 */
	public function removeAlbum(aAlbum:Album):Void
	{
		var tID:String = aAlbum.getIdString();
		if (tID != null)
		{
			if (contains(tID))
			{
				map.remove(tID);
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
	 * Returns current Picasa.Album object.
	 * @return Current Picasa.Album object.
	 */
	public function getCurrentAlbum():Album
	{
		return getAlbum(current);
	}
	/**
	 * Sets a Picasa.Album id as a current id.
	 * @param aID String, Picasa.Album id.
	 */
	public function setCurrent(aID:String):Void
	{
		current = aID;
		//iterator.setIndex(iterator.searchKey(aID));	//TEST!!!
	}
	/**
	 * Returns current album id(key).
	 * @return String, current album id.
	 */
	 public function getCurrent():String
	{
		return current;
	}
	/**
	 * Returns Picasa.Album object with specified ID.
	 * @param aID String, Picasa.Album id.
	 * @return Picasa.Album object with specified ID.
	 */
	public function getAlbum(aID:String):Album
	{
		if(!contains(aID)) {
			trace("Album "+aID+" is not available!",Log.ERROR);
		}
		
		setCurrent(aID);
		
		return map.get(aID);
	}
	/**
	 * Get next album from current album.
	 * @return Next Picasa.Album object in the map.
	 */
	public function getNextAlbum():Album
	{
		return getAlbum(iterator.next());
	}
	/**
	 * Get previous album from current album.
	 * @return Previous Picasa.Album object in the map.
	 */
	public function getPrevAlbum():Album
	{
		//???? TEST!!!
		return Album({});
		
		//if(!iterator.hasPrev()) {
		//	iterator.seek(size()+1);
		//}
		
		//return getAlbum(iterator.prev());
	}
	/**
	 * Returns Picasa Albums count.
	 * @return Albums count.	 */
	public function getAlbumsCount():Number
	{
		return size();
	}
	/**
	 * Returns a Map2 object with Picasa.Album objects.
	 * @return Map2 object with Picasa.Album objects.
	 */
	public function getAlbums():Map2
	{
		return map;
	}
	/**
	 * Called when successfully loaded xml!
	 */
	public function onInitialize(e:LibEvent):Void 
	{	
		if(map != undefined) return;
		
		map = new Map2();
		
		var tData = getData();
		var tEntries = tData.entry;	//array with <entry/> nodes
		
		for(var a = 0; a < tEntries.length; a++)
		{
			addAlbum(new Album(tEntries[a]),(a == 0));
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
		trace("Picasa.AlbumService.onFileProgress("+e.getPerCent()+"% loaded from "+e.getLib().getURL()+")",Log.INFO);
	}
	/**
	 * If xml loading timed out.
	 * @param e LibEvent event.
	 */
	public function onFileTimeout(e:LibEvent):Void
	{
		trace("Picasa.AlbumService.onFileTimeout("+e+")",Log.ERROR);
	}
	/**
	 * If xml loading failed.
	 * @param e LibEvent event.
	 */
	public function onFileError(e:LibEvent):Void
	{
		trace("Picasa.AlbumService.onFileError("+e+")",Log.ERROR);
	}
	public function toString():String
	{
		return PixlibStringifier.stringify(this);
	}
}