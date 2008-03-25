import com.bourre.core.Model;
import com.bourre.events.EventBroadcaster;
import com.bourre.events.IEvent;
import com.bourre.commands.Delegate;

import model.ModelList;
import control.photo.PhotosGetEvent;
import control.photo.PhotoChangedEvent;
import vo.Photos;

import sk.prasa.webapis.picasa.PicasaService;

/**
 * @author Michal Gron (michal.gron@gmail.com)
 */

class model.ModelApplication extends Model
{
	public var service : PicasaService;
	public var photos : Photos;
	
	public static var USERID : String = "thisispinkfu";
	public static var ALBUMID : String = "5094406297232552993";//	public static var ALBUMID : String = "5150986992011782785";	//splitzer//	public static var ALBUMID : String = "5161355527636525521";	//diana//	public static var ALBUMID : String = "5135051345581734225";	//tatry

	public function ModelApplication()
	{
		super(ModelList.MODEL_APPLICATION);
	}
	
	public function initialize(aUserid : String, aAlbumid : String) : Void
	{
		if(aUserid != undefined) USERID = aUserid;
		if(aAlbumid != undefined) ALBUMID = aAlbumid;
		
		photos = Photos.getInstance();

		service = PicasaService.getInstance();
		service.imgmax = 320;
		service.thumbsize = 64;
		service.max_results = 24;
		service.addEventListener(PicasaService.ERROR, Delegate.create(this, onServiceError));

		EventBroadcaster.getInstance().dispatchEvent(new PhotosGetEvent(USERID, ALBUMID));
	}

	public function next() : Void
	{ 
		var tId : String = photos.getNext();
		var tTitle : String = photos.getCurrentTitle();
		
		notifyChanged(new PhotoChangedEvent(tId, tTitle));
	}
	
	public function prev() : Void
	{
		var tId : String = photos.getPrevious();
		var tTitle : String = photos.getCurrentTitle();
		
		notifyChanged(new PhotoChangedEvent(tId, tTitle));
	}
	
	public function click(aId : String) : Void
	{	
		var tId : String = photos.getClicked(aId);
		var tTitle : String = photos.getCurrentTitle();
		
		notifyChanged(new PhotoChangedEvent(tId, tTitle));
	}
	
	private function onServiceError(evt : IEvent) : Void
	{
		trace("Service error.");
	}
}