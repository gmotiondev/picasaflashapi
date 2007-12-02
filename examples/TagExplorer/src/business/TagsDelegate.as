/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
import com.bourre.core.Model;
import com.bourre.events.NumberEvent;
import com.bourre.events.EventBroadcaster;

import sk.prasa.webapis.picasa.PicasaService;
import sk.prasa.webapis.picasa.events.PicasaResultEvent;

import model.*;
import command.IResponder;
import control.*;

class business.TagsDelegate
{
	private var __command:IResponder;
	private var __service:PicasaService;
	
	public function TagsDelegate(command:IResponder)
	{
		__command = command;
		__service = ModelApplication(Model.getModel(ModelList.MODEL_APPLICATION)).service;
	}
	
	public function list(aUsername:String):Void
	{		
		__service.addEventListener(PicasaService.PROGRESS, this); 
		__service.addEventListener(PicasaResultEvent.TAGS_GET_USER, this);
		__service.tags.user(aUsername);
	}

	private function tagsGetUser(e:PicasaResultEvent):Void
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
			trace("tags search failed: "+error.message)
		} 
		
		__service.removeEventListener(PicasaResultEvent.TAGS_GET_USER, this);
	}
	
	private function progress(event:NumberEvent):Void
	{
		EventBroadcaster.getInstance().broadcastEvent(new SetProgressEvent(NumberEvent(event).getNumber()));
	}
}