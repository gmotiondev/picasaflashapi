/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
import com.bourre.core.Model;
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

	public function ModelApplication()
	{
		super(ModelList.MODEL_APPLICATION);
	}

	public function initialize():Void
	{
		photos = new Photos();

		service = PicasaService.getInstance();
		service.max_results = 108;	//192
		service.thumbsize = 64;
		service.start_index = 1;
		service.addEventListener(PicasaService.ERROR, Delegate.create(this, onServiceError));
		service.addEventListener(PicasaService.TIMEOUT, Delegate.create(this, onServiceTimeout));
	}

	// next page button clicked
	public function setNextPage():Void
	{
		service.start_index += service.max_results;
	}

	// prev page button clicked
	public function setPrevPage():Void
	{
		service.start_index = (service.start_index - service.max_results) >= 1 ? (service.start_index - service.max_results) : 1;
	}

	public function onScreenResize(e:ScreenResizeEvent):Void
	{
		notifyChanged(e);
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