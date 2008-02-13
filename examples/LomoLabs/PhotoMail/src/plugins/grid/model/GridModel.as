/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
import com.bourre.ioc.model.AbstractModel;
import com.bourre.ioc.plugin.IPlugin;
import com.bourre.commands.Delegate;
import com.bourre.events.IEvent;

import plugins.grid.control.*;
import plugins.grid.vo.*;

class plugins.grid.model.GridModel extends AbstractModel
{	
	public var photos:Photos;
	
	public function GridModel(owner:IPlugin, name:String)
	{
		super(owner, name);
	}
	
	public function next():Void
	{
		var tChangedEvent:PhotoChangedEvent = new PhotoChangedEvent(photos.getNext());
		//var tTitleEvent:PhotoSetTitleEvent = new PhotoSetTitleEvent(photos.getCurrentTitle());
		
		notifyChanged(tChangedEvent);
		//notifyChanged(tTitleEvent);
	}
	
	public function prev():Void
	{
		var tChangedEvent:PhotoChangedEvent = new PhotoChangedEvent(photos.getPrevious());
		//var tTitleEvent:PhotoSetTitleEvent = new PhotoSetTitleEvent(photos.getCurrentTitle());
		
		notifyChanged(tChangedEvent);
		//notifyChanged(tTitleEvent);
	}
	
	public function click(aId:String):Void
	{
		notifyChanged(new PhotoChangedEvent(photos.getClicked(aId)));
	}
	
	public function onResize():Void
	{
		notifyChanged(new ResizeEvent(getOwner()));
	}
}