/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
import com.bourre.ioc.control.AbstractCommand;
import com.bourre.events.NumberEvent;
import com.bourre.events.BasicEvent;
import com.bourre.events.EventType;

import sk.prasa.webapis.picasa.Photo;
import sk.prasa.webapis.picasa.PicasaError;

import plugins.picasa.business.*;
import plugins.picasa.control.GetPhotosEvent;
import plugins.picasa.model.*;
import plugins.picasa.command.IResponder;

class plugins.picasa.command.GetPhotosCommand extends AbstractCommand implements IResponder
{
	private var __model:PicasaModel;
	private var __callbackChannel:String;
	
	public function execute(evt:GetPhotosEvent)
	{
		__model = PicasaModel(getModelLocator().getModel(ModelList.PICASA_MODEL));
		__callbackChannel = evt.callback;
		
		var d:GetPhotosDelegate = new GetPhotosDelegate(this, __model.service);
			d.list(evt.user, evt.album);
	}
	
	public function progress(percents:Number):Void
	{
		getOwner().firePublicEvent(new NumberEvent(new EventType("onProgress"),percents));
	}
	
	public function result(data:Array):Void
	{
		var tEvent:BasicEvent = new BasicEvent(new EventType("onGetPhotosEvent"), data);
		
		if(!__callbackChannel)
		{
			getOwner().firePublicEvent(tEvent);
		} else
		{
			getOwner().fireExternalEvent(tEvent,__callbackChannel);
		}
	}
	
	public function fault(error:PicasaError):Void
	{
		trace("GetPhotosCommand failed: "+error.message);
	}
}