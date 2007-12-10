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
		service.addEventListener(PicasaService.ERROR, Delegate.create(this, onServiceError));

		EventBroadcaster.getInstance().dispatchEvent(new PhotosGetEvent("thisispinkfu","5094406297232552993"));
	}
	
	public function next():Void
	{
		var tChangedEvent:PhotoChangedEvent = new PhotoChangedEvent(photos.getNext());
		var tTitleEvent:PhotoSetTitleEvent = new PhotoSetTitleEvent(photos.getCurrentTitle());
		
		notifyChanged(tChangedEvent);
		notifyChanged(tTitleEvent);
	}
	
	public function prev():Void
	{
		var tChangedEvent:PhotoChangedEvent = new PhotoChangedEvent(photos.getPrevious());
		var tTitleEvent:PhotoSetTitleEvent = new PhotoSetTitleEvent(photos.getCurrentTitle());
		
		notifyChanged(tChangedEvent);
		notifyChanged(tTitleEvent);
	}
	
	public function click(aId:String):Void
	{	
		var tChangedEvent:PhotoChangedEvent = new PhotoChangedEvent(photos.getClicked(aId));
		var tTitleEvent:PhotoSetTitleEvent = new PhotoSetTitleEvent(photos.getCurrentTitle());
		
		notifyChanged(tChangedEvent);
		notifyChanged(tTitleEvent);
	}
	
	private function onServiceError(e:IEvent):Void
	{
		trace("error: "+e.getType());
	}
}