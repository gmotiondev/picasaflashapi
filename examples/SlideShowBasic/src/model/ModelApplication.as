import com.bourre.core.Model;
import com.bourre.events.EventBroadcaster;
import com.bourre.events.IEvent;
import com.bourre.commands.Delegate;
import com.bourre.commands.CommandMS;

import model.ModelList;
import control.*;
import vo.Photos;

import sk.prasa.webapis.picasa.PicasaService;

/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
class model.ModelApplication extends Model
{
	public var service:PicasaService;
	public var photos:Photos;
	public var container:MovieClip;

	private var __t:CommandMS;
	private var __isPlaying:Boolean = true;
	
	public function ModelApplication()
	{
		super(ModelList.MODEL_APPLICATION);
	}
	
	public function initialize():Void
	{
		photos = new Photos();

		service = new PicasaService();
		service.imgmax = 320;
		service.addEventListener(PicasaService.ERROR, Delegate.create(this, onServiceError));

		EventBroadcaster.getInstance().dispatchEvent(new PhotosGetEvent("thisispinkfu","5094406297232552993"));
	}
	
	public function pause(force:Boolean):Void
	{
		if(force && !__isPlaying) return;
		
		__isPlaying ? __t.stopWithName("slideshow") : __t.resumeWithName("slideshow");
		__isPlaying = !__isPlaying;
	}
	
	public function start():Void
	{
		__t = new CommandMS();
		__t.pushWithName(new Delegate(this, next, __t), 5000, "slideshow");
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
	
	private function onServiceError(e:IEvent):Void
	{
		trace("error: "+e.getType());
	}
}