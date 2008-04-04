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
			for(var tKey : String in aItems) if(tKey != "entry") tParent[tKey] = aItems[tKey];
			
			var tLen : Number = (aItems.entry.length != undefined) ? aItems.entry.length : 1;

			for(var a : Number = 0; a < tLen; a++)
			{
				// pixlib fix with one item
				var tItem : Object = (tLen == 1) ? aItems.entry : aItems.entry[a];
				var tKind : String = (tItem.category.attributes.term).split("#")[1];

				switch(tKind)
				{
					//case KindType.USER	: tRes.push(new User(tItem)); break;
					case KindType.ALBUM		: tRes.push(new Album(tItem, tParent)); break;
					case KindType.COMMENT 	: tRes.push(new Comment(tItem, tParent)); break;
					case KindType.TAG 		: tRes.push(new Tag(tItem, tParent)); break;
					case KindType.PHOTO		: 
					default: tRes.push(new Photo(tItem, tParent)); break;
				}
			}

			return tRes;
		} catch(e : Error)
		{
			throw new Error(e.message);
		}

		return null;
	}
	
	public function fault(evt : XMLToObjectEvent) : Void
	{
		var tObj : Object = evt.getObject();
		
		var tEvt : PicasaEvent = new PicasaEvent(PicasaService.ERROR);
			tEvt.success = false;
			tEvt.error = new PicasaError(tObj.toString());
		
		service.dispatchEvent(tEvt);
	}
}
