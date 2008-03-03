import com.bourre.core.Model;
import com.bourre.events.EventBroadcaster;
import com.bourre.events.IEvent;
import com.bourre.commands.Delegate;

import model.ModelList;
import control.*;
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
	public static var ALBUMID : String = "5135051345581734225";

	public function ModelApplication()
	{
		super(ModelList.MODEL_APPLICATION);
	}
	
	public function initialize() : Void
	{
		photos = Photos.getInstance();
		service = new PicasaService();
		service.max_results = 9;
		service.thumbsize = 48;
		service.imgmax = 288;
		service.addEventListener(PicasaService.ERROR, Delegate.create(this, onServiceError));

		EventBroadcaster.getInstance().dispatchEvent(new GetAlbumEvent(USERID, ALBUMID));
	}
	
	public function next() : Void
	{
		var tId:String = photos.getNext();
		var tTitle:String = photos.getCurrentTitle();
		
		notifyChanged(new PhotoChangedEvent(tId, tTitle));
	}
	
	public function prev() : Void
	{
		var tId:String = photos.getPrevious();
		var tTitle:String = photos.getCurrentTitle();

		notifyChanged(new PhotoChangedEvent(tId, tTitle));
	}
	
	public function click(aId : String) : Void
	{
		var tId:String = photos.getClicked(aId);
		var tTitle:String = photos.getCurrentTitle();
		
		notifyChanged(new PhotoChangedEvent(tId, tTitle));
	}
	
	private function onServiceError(evt : IEvent) : Void
	{
	}
}