/**
 * @author Michal Gron (michal.gron@gmail.com)
 */

import com.bourre.ioc.control.AbstractCommand;

import com.bourre.events.BasicEvent;
import com.bourre.events.EventType;

import plugins.grid.control.*;
import plugins.grid.control.dialog.*;
import plugins.grid.model.*;

class plugins.grid.command.PhotoSendCommand extends AbstractCommand
{
	private var __model:GridModel;
	
	public function execute(evt:PhotoSendEvent):Void
	{
		__model = GridModel(getModelLocator().getModel(ModelList.GRID_MODEL));
		
		var tEvent:BasicEvent = new BasicEvent(new EventType("onSendPhoto"),{
			from: evt.from,
			to: evt.to,
			desc: evt.desc,
			url: __model.photos.getCurrentUrl(),
			id: evt.id
		});
		
		getOwner().firePublicEvent(tEvent);
		getOwner().firePrivateEvent(new GetSendingDialogEvent(getOwner(), evt.id));
	}
}