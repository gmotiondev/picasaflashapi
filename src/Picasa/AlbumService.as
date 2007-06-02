import com.bourre.events.IEvent;
import com.bourre.log.PixlibStringifier;

import Picasa.Album;
import Picasa.Service;

// Iterators
//import com.bourre.data.collections.Map;
//import com.bourre.data.iterator.ObjectIterator;
import Picasa.tools.Map2;
import Picasa.tools.ObjectIterator2;

/**
 * @author Michal Gron
 */
class Picasa.AlbumService extends Service
{
	private var __map : Map2;	//
	private var __current : String;
	private var __old : String;
	private var __it : ObjectIterator2;
	
	public var onServiceLoaded : Function;	//Invokers
	
	/**
	 * Constructor
	 */
	public function AlbumService(aParent:Object)
	{
		super();
		
		__current = null;
		__old = null;
	}
	/**
	 * 
	 */
	public function addAlbum(aAlbum:Album,aSetCurrent:Boolean):Void
	{
		var tID:String = aAlbum.getIdString();
		
		if(tID != null)
		{
			if(!contains(tID))
			{
				trace("Putting album: "+aAlbum.getTitle())
				__map.put(tID,aAlbum);
				
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
	 * 
	 */
	public function removeAlbum(aAlbum:Album):Void
	{
		var tID:String = aAlbum.getIdString();
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
	public function getCurrentAlbum():Album
	{
		return getAlbum(__current);
	}
	/**
	 * 
	 */
	public function setCurrent(aID:String):Void
	{
		__current = aID;
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
	public function getAlbum(aID:String):Album
	{
		if(!contains(aID)) {
			trace("Album "+aID+" is not available!",Log.ERROR);
		}
		
		setCurrent(aID);
		
		return __map.get(aID);
	}
	/**
	 * 
	 */
	public function getNextAlbum():Album
	{
		return getAlbum(__it.next());
	}
	/**
	 * 
	 */
	public function getPrevAlbum():Album
	{
		//???
		return Album({});
	}
	/**
	 * 
	 */
	public function getAlbums()
	{
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
	 * Called when successfully loaded xml!
	 */
	private function onInitialize(e:IEvent):Void 
	{	
		if(__map != undefined) return;
		
		__map = new Map2();
		
		var tData = getData();
		var tEntries = tData.entry;
		
		for(var a = 0; a < tEntries.length; a++)
		{
			addAlbum(new Album(tEntries[a]),(a == 0));
		}
		
		reset();
		notifyChanged(e);
	}
	/**
	 * 
	 */
	private function notifyChanged(e:IEvent):Void
	{
		onServiceLoaded(e);
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
		trace("com.kvenda.services.AlbumService.onFileError("+e+")",Log.ERROR);
	}
	
	public function toString():String
	{
		return PixlibStringifier.stringify(this);
	}
}