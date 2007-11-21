/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
import com.bourre.core.Model;
// import com.bourre.commands.Delegate;
import com.bourre.events.NumberEvent;
import com.bourre.events.EventBroadcaster;

import sk.prasa.webapis.picasa.PicasaService;
import sk.prasa.webapis.picasa.events.PicasaResultEvent;
import sk.prasa.webapis.picasa.core.NameValuePair;
import sk.prasa.webapis.picasa.UrlParams;

import model.*;
import command.IResponder;
import control.*;

class business.PhotosDelegate
{
	private var __command:IResponder;
	private var __service:PicasaService;
	
	public function PhotosDelegate(command:IResponder)
	{
		__command = command;
		__service = ModelApplication(Model.getModel(ModelList.MODEL_APPLICATION)).service;
	}
	
	public function search(aQuery:String):Void
	{		
		__service.addEventListener(PicasaService.PROGRESS, this); 
		__service.addEventListener(PicasaResultEvent.COMMUNITY_GET_SEARCH, this);
		__service.community.search(aQuery);
	}

	private function communityGetSearch(e:PicasaResultEvent):Void
	{
		try
		{
			if(e.success) {
				__command.result(e.data);
			} else {
				__command.fault(e.error);
			}
		} catch(error:Error)
		{
			trace("community search failed: "+error.message)
		} 
		
		__service.removeEventListener(PicasaResultEvent.COMMUNITY_GET_SEARCH, this);
	}
	
	private function progress(event:NumberEvent):Void
	{
		EventBroadcaster.getInstance().broadcastEvent(new SetProgressEvent(NumberEvent(event).getNumber()));
	}
}