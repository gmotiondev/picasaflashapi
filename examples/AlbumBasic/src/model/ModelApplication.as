/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
import com.bourre.core.Model;
import com.bourre.events.EventBroadcaster;
import com.bourre.events.IEvent;
import com.bourre.commands.Delegate;

import model.ModelList;
import control.*;
import vo.Photos;

import sk.prasa.webapis.picasa.PicasaService;

class model.ModelApplication extends Model
{
	public var service:PicasaService;
	public var photos:Photos;
	public var container:MovieClip;
	
	public function ModelApplication()
	{
		super(ModelList.MODEL_APPLICATION);
	}
	
	public function initialize():Void
	{
		photos = new Photos();

		service = new PicasaService();
		service.imgmax = 320;
		service.thumbsize = 72;
		service.max_results = 24;
		service.addEventListener(PicasaService.ERROR, Delegate.create(this, onServiceError));

		EventBroadcaster.getInstance().dispatchEvent(new PhotosGetEvent("thisispinkfu","5094406297232552993"));
	}
	
	public function next():Void
	{ 
		var tId:String = photos.getNext();
		var tTitle:String = photos.getCurrentTitle();
		
		notifyChanged(new PhotoChangedEvent(tId, tTitle));
	}
	
	public function prev():Void
	{
		var tId:String = photos.getPrevious();
		var tTitle:String = photos.getCurrentTitle();
		
		notifyChanged(new PhotoChangedEvent(tId, tTitle));
	}
	
	public function click(aId:String):Void
	{	
		var tId:String = photos.getClicked(aId);
		var tTitle:String = photos.getCurrentTitle();
		
		notifyChanged(new PhotoChangedEvent(tId, tTitle));
	}
	
	public function onScreenResize(evt:ScreenResizeEvent):Void
	{
		notifyChanged(evt);
	}
	
	private function onServiceError(e:IEvent):Void
	{
		trace("error: "+e.getType());
	}
}