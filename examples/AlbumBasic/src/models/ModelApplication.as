import com.bourre.core.Model;
import com.bourre.events.IEvent;import com.bourre.events.BasicEvent;
import com.bourre.events.EventBroadcaster;

import models.ModelList;
import events.EventList;

/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
class models.ModelApplication extends Model
{
	private var __c:MovieClip;
	private var __pps:Picasa.AlbumService;
	private var __feed:String = "http://picasaweb.google.com/data/feed/api/user/thisispinkfu";
	private var __albumid:String = "5071041246998165969";
	
	public function ModelApplication()
	{
		super(ModelList.MODEL_APPLICATION);
	}
	
	public function initialize():Void
	{
		trace("models.ModelApplication.initialize()",Log.INFO);
		run();
	}
	
	public function setContainer(mc:MovieClip):Void
	{
		__c = mc;
	}
	
	public function getContainer():MovieClip
	{
		return __c;
	}
	
	public function getNextPhoto():Void
	{
		var tPPS:Picasa.AlbumService = getAlbumService();
		var tPP:Picasa.Photo = tPPS.getNextPhoto();

		notifyChanged(new BasicEvent(EventList.PHOTO_THUMB_CLICK,tPP));
	}
	
	public function getPrevPhoto():Void
	{
		var tPPS:Picasa.AlbumService = getAlbumService();
		var tPP:Picasa.Photo = tPPS.getPrevPhoto();
		
		notifyChanged(new BasicEvent(EventList.PHOTO_THUMB_CLICK,tPP););
	}
	
	public function setCurrentPhoto(aId:String):Void
	{
		getAlbumService().setCurrent(aId);
	}
	
	public function getAlbumService():Picasa.AlbumService
	{
		return __pps;
	}
	
	public function PhotoThumbClick(p:Picasa.Photo):Void
	{	
		var tE = new BasicEvent(EventList.PHOTO_THUMB_CLICK,p);
		
		setCurrentPhoto(p.getIdString());
		notifyChanged(tE);
	}
	
	public function run():Void
	{
		__pps = new Picasa.AlbumService(__feed,__albumid);
		__pps.onServiceLoaded = function(aEvent:IEvent)
		{
			EventBroadcaster.getInstance().broadcastEvent(new BasicEvent(EventList.SERVICE_LOADED));
		}
		__pps.load();
	}
}
