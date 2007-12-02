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
	public var container:MovieClip;
	
	public function ModelApplication()
	{
		super(ModelList.MODEL_APPLICATION);
	}
	
	public function initialize():Void
	{
		photos = new Photos();

		service = new PicasaService();
		service.max_results = 192;
		service.thumbsize = 48;
		service.start_index = 1;
		service.addEventListener(PicasaService.ERROR, Delegate.create(this, onServiceError));
	}
	
	public function nextPage():Void
	{
		service.start_index += service.max_results;
		notifyChanged(new GetPageEvent("next"));
	}
	
	public function prevPage():Void
	{
		service.start_index = (service.start_index <= service.max_results) ? 1 : service.start_index - service.max_results;
		notifyChanged(new GetPageEvent("prev"));
	}
	
	public function onScreenResize(e:ScreenResizeEvent):Void
	{
		notifyChanged(e);
	}
	
	private function onServiceError(e:IEvent):Void
	{
		trace("error: "+e.getType());
	}	
}