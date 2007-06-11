import com.bourre.core.Model;
//import com.bourre.events.IEvent;import com.bourre.events.BasicEvent;
import com.bourre.events.EventBroadcaster;
import com.bourre.commands.Delegate;import com.bourre.commands.CommandMS;

import models.ModelList;
import events.EventList;

/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
class models.ModelApplication extends Model
{
	private var __t:CommandMS;
	private var __c:MovieClip;
	private var __isPlaying:Boolean = true;
	private var __pps:Picasa.PhotoService;
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
		var tPPS:Picasa.PhotoService = getPhotoService();
		var tPP:Picasa.Photo = tPPS.getNextPhoto();

		notifyChanged(new BasicEvent(EventList.PHOTO_CHANGED,tPP));
	}
	
	public function getPrevPhoto():Void
	{
		var tPPS:Picasa.PhotoService = getPhotoService();
		var tPP:Picasa.Photo = tPPS.getPrevPhoto();
		
		notifyChanged(new BasicEvent(EventList.PHOTO_CHANGED,tPP););
	}
	
	public function setCurrentPhoto(aId:String):Void
	{
		getPhotoService().setCurrent(aId);
	}
	
	public function getPhotoService():Picasa.PhotoService
	{
		return __pps;
	}
	
	public function photoClick()
	{
		__isPlaying ? __t.stopWithName("slideshow") : __t.resumeWithName("slideshow");
		__isPlaying = !__isPlaying;
		
		notifyChanged(new BasicEvent(EventList.PHOTO_CLICK));
	}
	
	public function run():Void
	{
		__pps = new Picasa.PhotoService(__feed,__albumid);
		__pps.onServiceLoaded = Delegate.create(this,onServiceLoaded);		__pps.load();
	}
	
	private function onServiceLoaded():Void
	{
		EventBroadcaster.getInstance().broadcastEvent(new BasicEvent(EventList.SERVICE_LOADED));
	}
	
	public function startSlideShow():Void
	{
		__t = new CommandMS();
		__t.pushWithName(new Delegate(this, getNextPhoto, __t), 5000, "slideshow");
	}
}