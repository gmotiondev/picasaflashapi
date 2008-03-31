import com.bourre.data.libs.XMLToObject;
import com.bourre.data.libs.XMLToObjectEvent;
import com.bourre.events.EventType;

import sk.prasa.webapis.picasa.*;
import sk.prasa.webapis.picasa.events.PicasaEvent;

/**
 * @author Michal Gron (michal.gron@gmail.com)
 */

class sk.prasa.webapis.picasa.core.receiver.GetFeedReceiver 
{
	private var service : PicasaService;

	public function GetFeedReceiver()
	{
		service = PicasaService.getInstance();
	}

	private function process(response : Object, eventType : EventType) : Void 
	{
		try
		{
			for(var tKey in response) trace(tKey + "/" + response[tKey]);

			if(response.id != null && response.id != undefined && response.id != "")
			{
				var tEvt : PicasaEvent = new PicasaEvent(eventType);
					tEvt.success = true;
					tEvt.data = parse(response);
					
					service.broadcastEvent(tEvt);
			} else
			{
				fault(new XMLToObjectEvent(eventType, XMLToObject(response)));
			}
		} catch(e : Error)
		{
			throw new Error(e.message);
		}
	}
	
	private function parse(aItems : Object) : Array
	{
		try
		{
			var tRes : Array = new Array();
			var tParent : Object = new Object();
			
			// copy aItems without entries to new object
			for(var tKey : String in aItems) if(tKey != "entry") tParent[tKey] = aItems[tKey]
			
			for(var a : Number = 0; a < aItems.entry.length; a++)
			{
				var tItem : Object = aItems.entry[a];
				var tKind : String = (tItem.category.attributes.term).split("#")[1];
				
				switch(tKind)
				{
					//case KindType.USER	: tRes.push(new User(tItem)); break;
					case KindType.ALBUM		: tRes.push(new Album(tItem, tParent)); break;
					case KindType.PHOTO		: tRes.push(new Photo(tItem, tParent)); break;
					case KindType.COMMENT 	: tRes.push(new Comment(tItem, tParent)); break;
					case KindType.TAG 		: tRes.push(new Tag(tItem, tParent)); break;
					default: break;
				}
			}

			return tRes;
		} catch(e : Error)
		{
			throw new Error(e.message);
		}

		return null;
	}
	
	
	/*
	private function getResponse(resp : Object, func : Function) : Object
	{
		var tResult : Object = {};
			tResult["data"] = {};
			tResult["error"] = {};
		
		if (resp["error"] == null)
		{
			tResult["success"] = true;
			tResult["data"] = (func == null) ? resp : func(resp);		
		} else
		{
			tResult["success"] = false;
			tResult["error"] = new PicasaError(resp["error"]["message"]);
		}
		
		return tResult;	
	}
	*/
	public function fault(evt : XMLToObjectEvent) : Void
	{
		var tObj : Object = evt.getObject();
		
		var tEvt : PicasaEvent = new PicasaEvent(PicasaService.ERROR);
			tEvt.success = false;
			tEvt.error = new PicasaError(tObj.toString());
		
		service.dispatchEvent(tEvt);
	}
}
