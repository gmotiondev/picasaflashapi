import control.ErrorEvent;

import com.bourre.commands.Delegate;
import com.bourre.core.Model;
import com.bourre.events.IEvent;

import sk.prasa.webapis.picasa.PicasaService;

import model.ModelList;
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

		service = new PicasaService();
		service.max_results = 108;
		service.thumbsize = 64;
		service.start_index = 1;
		service.addEventListener(PicasaService.ERROR, Delegate.create(this, onServiceError));
		service.addEventListener(PicasaService.TIMEOUT, Delegate.create(this, onServiceTimeout));
	}

	public function setNextPage() : Void
	{
		service.start_index += service.max_results;
	}

	public function setPrevPage() : Void
	{
		service.start_index = (service.start_index - service.max_results) >= 1 ? (service.start_index - service.max_results) : 1;
	}

	private function onServiceError(evt : IEvent) : Void
	{
		notifyChanged(new ErrorEvent(evt.getType() + ": Unable to load feed."));
	}

	private function onServiceTimeout(evt : IEvent) : Void
	{
		notifyChanged(new ErrorEvent(evt.getType() + ": Feed loading time out."));
	}
}