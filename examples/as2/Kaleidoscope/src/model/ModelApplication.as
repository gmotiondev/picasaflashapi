import com.bourre.commands.Delegate;
import com.bourre.core.Model;
import com.bourre.events.EventBroadcaster;
import com.bourre.events.IEvent;
import com.bourre.events.NumberEvent;

import control.*;
import model.ModelList;
import sk.prasa.webapis.picasa.PicasaService;
import vo.Photos;

/**
 * @author Michal Gron (michal.gron@gmail.com)
 */

class model.ModelApplication extends Model
{
	public var service : PicasaService;
	public var photos : Photos;

	public function ModelApplication()
	{
		super(ModelList.MODEL_APPLICATION);
	}

	public function initialize() : Void
	{
		photos = Photos.getInstance();

		service = PicasaService.getInstance();
		service.max_results = 15;
		service.imgmax = 512;
		service.addEventListener(PicasaService.PROGRESS, Delegate.create(this, onServiceProgress));
		service.addEventListener(PicasaService.ERROR, Delegate.create(this, onServiceError));
		service.addEventListener(PicasaService.TIMEOUT, Delegate.create(this, onServiceTimeout));

		EventBroadcaster.getInstance().broadcastEvent(new InitializeEvent("thisispinkfu", "salzburg"));
	}

	public function next() : Void
	{
		var tId : String = photos.getNext();
		var tUrl : String = photos.getCurrentUrl();

		notifyChanged(new PhotoChangedEvent(tId, tUrl));
	}

	public function prev() : Void
	{
		var tId : String = photos.getPrevious();
		var tUrl : String = photos.getCurrentUrl();

		notifyChanged(new PhotoChangedEvent(tId, tUrl));
	}

	public function onResize() : Void
	{
		notifyChanged(new ResizeEvent());
	}

	private function onServiceProgress(evt : NumberEvent) : Void
	{
		notifyChanged(new ProgressEvent(evt.getNumber()));
	}

	private function onServiceError(evt : IEvent) : Void
	{
		trace("error: " + evt.getType());
	}

	private function onServiceTimeout(evt : IEvent) : Void
	{
		trace("timeout: " + evt.getType());
	}
}