/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
import com.bourre.events.IEvent;
import com.bourre.data.libs.LibEvent;

import Picasa.Photo;
import Picasa.Service;
import Picasa.IService;
import Picasa.tools.Map2;

/**
 * get xml photo header, just one entries ... 
 */
class Picasa.PhotoService extends Service implements IService
{
	private var __kind:String = "comment";

	/**
	 * Constructor
	 */
	public function PhotoService(aFeed:String, aAlbumId:String, aGetParams:Object)
	{
		super(new AlbumRequest(aFeed, aAlbumId, aGetParams));
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
			//addPhoto(new Photo(tEntries[a]),(a == 0));
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
		//trace("Picasa.PhotoService.onFileProgress("+e.getPerCent()+"% loaded from "+e.getLib().getURL()+")",Log.INFO);
	}
	/**
	 * If xml loading timed out.
	 * @param e LibEvent event.
	 */
	public function onFileTimeout(e:LibEvent):Void
	{
		trace("ERROR: Picasa.PhotoService.onFileTimeout("+e+")");
	}
	/**
	 * If xml loading failed.
	 * @param e LibEvent event.
	 */
	public function onFileError(e:LibEvent):Void
	{
		trace("ERROR: Picasa.PhotoService.onFileError("+e+")");
	}
}