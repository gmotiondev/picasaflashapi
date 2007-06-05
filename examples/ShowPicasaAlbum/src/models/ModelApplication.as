import com.bourre.core.Model;
import com.bourre.events.IEvent;import com.bourre.events.BasicEvent;
import com.bourre.events.EventBroadcaster;
import com.bourre.visual.MovieClipHelper;

import models.ModelList;
import events.EventList;

/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
class models.ModelApplication extends Model
{
	private var __c:MovieClip;
	private var __pps:Picasa.PhotoService;
	private var __feed:String = "http://picasaweb.google.com/data/feed/api/user/thisispinkfu/albumid/5071041246998165969?kind=photo";
	
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
		var tPPS:Picasa.PhotoService = getPhotoService();
		var tPP:Picasa.Photo = tPPS.getNextPhoto();

		notifyChanged(new BasicEvent(EventList.PHOTO_THUMB_CLICK,tPP));
	}
	
	public function getPrevPhoto():Void
	{
		var tPPS:Picasa.PhotoService = getPhotoService();
		var tPP:Picasa.Photo = tPPS.getPrevPhoto();
		
		notifyChanged(new BasicEvent(EventList.PHOTO_THUMB_CLICK,tPP););
	}
	
	public function setCurrentPhoto(aId:String):Void
	{
		getPhotoService().setCurrent(aId);
	}
	
	public function getPhotoService():Picasa.PhotoService
	{
		return __pps;
	}
	
	public function PhotoThumbClick(p:Picasa.Photo):Void
	{	
		var tE = new BasicEvent(EventList.PHOTO_THUMB_CLICK,p);
		
		var tPhotoId = p.getIdString();
		var tPhotoMc = MovieClipHelper.getMovieClipHelper(tPhotoId);
			tPhotoMc.show();
		
		setCurrentPhoto(tPhotoId);
		notifyChanged(tE);
	}
	
	public function run():Void
	{
		__pps = new Picasa.PhotoService();
		__pps.onServiceLoaded = function(aEvent:IEvent)
		{
			EventBroadcaster.getInstance().broadcastEvent(new BasicEvent(EventList.SERVICE_LOADED,this));
		}
		__pps.load(__feed);
	}
}
