/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
import com.bourre.ioc.model.AbstractModel;
import com.bourre.ioc.plugin.IPlugin;
import com.bourre.commands.Delegate;
import com.bourre.events.IEvent;

import plugins.grid.control.PhotoChangedEvent;
import plugins.grid.vo.Photos;

class plugins.grid.model.GridModel extends AbstractModel
{	
	public var photos:Photos;
	
	public function GridModel(owner:IPlugin, name:String)
	{
		super(owner, name);
		
		initialize();
	}
	
	public function initialize():Void
	{

	}
	
	public function click(aId:String):Void
	{
		var tChangedEvent:PhotoChangedEvent = new PhotoChangedEvent(photos.getClicked(aId));
		
		notifyChanged(tChangedEvent);
	}
}