import com.bourre.core.Model;
//import com.bourre.events.IEvent;
import com.bourre.data.libs.LibEvent;import com.bourre.events.BasicEvent;
import com.bourre.events.EventBroadcaster;
import com.bourre.commands.Delegate;import com.bourre.commands.CommandMS;

import model.ModelList;
import events.EventList;

/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
class model.ModelApplication extends Model
{
	private var __t:CommandMS;
	private var __c:MovieClip;
	private var __isPlaying:Boolean = true;
	private var __pps:Picasa.PhotoService;
	
	private var PROXY_URL:String = "http://prasa.sk/proxy.php?gws_path=";
	
	private var __feed:String = PROXY_URL+"http://picasaweb.google.com/data/feed/api/user/thisispinkfu";
	private var __albumid:String = "5094406297232552993";
	
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
		
		notifyChanged(new BasicEvent(EventList.PHOTO_CLICK,__isPlaying));
	}
	public function pause():Void
	{
		if(__isPlaying) photoClick();
	}
	public function play():Void
	{
		if(!__isPlaying) photoClick();
	}
	private function run():Void
	{
		__pps = new Picasa.PhotoService(__feed,__albumid);
		__pps.onServiceLoaded = Delegate.create(this, onServiceLoaded);
		__pps.onFileProgress = Delegate.create(this, onFileProgress);		__pps.load();
	}
	private function onFileProgress(e:LibEvent):Void
	{
		EventBroadcaster.getInstance().broadcastEvent(new BasicEvent(EventList.SET_LOADER_PROGRESS,e.getPerCent()));
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