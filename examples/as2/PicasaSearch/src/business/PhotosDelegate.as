/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
import com.bourre.core.Model;
import com.bourre.events.NumberEvent;
import com.bourre.events.EventBroadcaster;

import sk.prasa.webapis.picasa.PicasaService;
import sk.prasa.webapis.picasa.events.PicasaEvent;

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
		__service.addEventListener(PicasaEvent.COMMUNITY_GET_SEARCH, this);
		__service.community.search(aQuery);
	}

	private function communityGetSearch(e:PicasaEvent):Void
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
		
		__service.removeEventListener(PicasaEvent.COMMUNITY_GET_SEARCH, this);
	}
	
	private function progress(event:NumberEvent):Void
	{
		EventBroadcaster.getInstance().broadcastEvent(new SetProgressEvent(NumberEvent(event).getNumber()));
	}
}