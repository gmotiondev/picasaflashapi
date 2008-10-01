import com.bourre.commands.Delegate;
import com.bourre.core.Model;
import com.bourre.events.EventBroadcaster;
import com.bourre.events.IEvent;
import com.bourre.events.NumberEvent;

import control.*;
import model.ModelList;
import vo.*;

import sk.prasa.webapis.picasa.PicasaService;

/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
class model.ModelApplication extends Model
{
	public var service:PicasaService;
	public var photos:Photos;
	public var albums:Albums;

	public function ModelApplication()
	{
		super(ModelList.MODEL_APPLICATION);
	}

	public function initialize():Void
	{
		photos = new Photos();
		albums = new Albums();

		service = new PicasaService();
		service.max_results = 16;
		service.thumbsize = 160;
		service.imgmax = 512;
		service.addEventListener(PicasaService.PROGRESS, Delegate.create(this, onServiceProgress));
		service.addEventListener(PicasaService.ERROR, Delegate.create(this, onServiceError));
		service.addEventListener(PicasaService.TIMEOUT, Delegate.create(this, onServiceTimeout));

		EventBroadcaster.getInstance().broadcastEvent(new InitializeAlbumsEvent("thisispinkfu"));
	}

//	public function next():Void
//	{
//		var tId:String = photos.getNext();
//		var tUrl:String = photos.getCurrentUrl();

		//notifyChanged(new PhotoChangedEvent(tId, tUrl));
//	}

//	public function prev():Void
//	{
//		var tId:String = photos.getPrevious();
//		var tUrl:String = photos.getCurrentUrl();

		//notifyChanged(new PhotoChangedEvent(tId, tUrl));
//	}

	public function onResize():Void
	{
		//notifyChanged(new ResizeEvent());
	}

	private function onServiceProgress(evt:NumberEvent):Void
	{
		//notifyChanged(new ProgressEvent(evt.getNumber()));
	}

	private function onServiceError(evt:IEvent):Void
	{
		trace("error: "+evt.getType());
	}

	private function onServiceTimeout(evt:IEvent):Void
	{
		trace("timeout: "+evt.getType());
	}
}