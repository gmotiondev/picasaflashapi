/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
import com.bourre.core.Model;
import com.bourre.events.IEvent;
import com.bourre.events.EventBroadcaster;
import com.bourre.commands.Delegate;

import model.ModelList;
import control.*;
import vo.Photos;

import sk.prasa.webapis.picasa.PicasaService;

class model.ModelApplication extends Model
{
	public var service:PicasaService;
	public var photos:Photos;
	
	public function ModelApplication()
	{
		super(ModelList.MODEL_APPLICATION);
	}
	
	public function initialize():Void
	{
		photos = new Photos();

		service = new PicasaService();
		service.max_results = 5;
		service.imgmax = 512;
		service.addEventListener(PicasaService.ERROR, Delegate.create(this, onServiceError));
		service.addEventListener(PicasaService.TIMEOUT, Delegate.create(this, onServiceTimeout));
		
		EventBroadcaster.getInstance().broadcastEvent(new InitializeEvent("thisispinkfu","salzburg"));
	}
	
	public function next():Void
	{
		var tId:String = photos.getNext();
		var tUrl:String = photos.getCurrentUrl();
		
		notifyChanged(new PhotoChangedEvent(tId, tUrl));
	}
	
	public function prev():Void
	{
		var tId:String = photos.getPrevious();
		var tUrl:String = photos.getCurrentUrl();
		
		notifyChanged(new PhotoChangedEvent(tId, tUrl));
	}
	
	public function onResize():Void
	{
		notifyChanged(new ResizeEvent());
	}
	
	private function onServiceError(e:IEvent):Void
	{
		trace("error: "+e.getType());
	}
	
	private function onServiceTimeout(e:IEvent):Void
	{
		trace("timeout: "+e.getType());
	}
}