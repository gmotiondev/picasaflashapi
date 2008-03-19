/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
import com.bourre.core.Model;
import com.bourre.events.EventBroadcaster;
import com.bourre.events.IEvent;
import com.bourre.commands.Delegate;
import com.bourre.visual.ViewHelper;

import model.ModelList;
import control.*;
import view.ViewList;
import vo.*;

import sk.prasa.webapis.picasa.PicasaService;

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

		service = PicasaService.getInstance();
		service.addEventListener(PicasaService.ERROR, Delegate.create(this, onServiceError));

		EventBroadcaster.getInstance().dispatchEvent(new AlbumsGetEvent("picasaflashapi"));
	}

	public function dispatch_change(p:String,d:Object):Void
	{
		notifyChanged(new control.ChangeEvent(p, d));
	}

	private function onServiceError(e:IEvent):Void
	{
		trace("error: "+e.getType());
	}
}