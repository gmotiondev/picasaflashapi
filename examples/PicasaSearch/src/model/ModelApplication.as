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
		service.max_results = 200;
		service.thumbsize = 48;
		service.addEventListener(PicasaService.ERROR, Delegate.create(this, onServiceError));

		EventBroadcaster.getInstance().dispatchEvent(new GetPhotosEvent("lomo"));
	}
	
	private function onServiceError(e:IEvent):Void
	{
		trace("error: "+e.getType());
	}	
}