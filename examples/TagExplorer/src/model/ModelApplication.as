/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
import com.bourre.core.Model;
import com.bourre.events.IEvent;
import com.bourre.events.EventBroadcaster;
import com.bourre.commands.Delegate;

import model.ModelList;
import control.*;
import vo.*;

import sk.prasa.webapis.picasa.PicasaService;

class model.ModelApplication extends Model
{
	public var service:PicasaService;
	public var photos:Photos;
	public var tags:Tags;
	public var userid:String;
	public var container:MovieClip;
	
	public function ModelApplication()
	{
		super(ModelList.MODEL_APPLICATION);
	}
	
	public function initialize():Void
	{
		photos = new Photos();
		tags = new Tags();
		userid = "thisispinkfu";
		service = new PicasaService();
		service.max_results = 25;
		service.thumbsize = 48;

		service.addEventListener(PicasaService.ERROR, Delegate.create(this, onServiceError));
		
		EventBroadcaster.getInstance().broadcastEvent(new GetTagsEvent(userid));
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