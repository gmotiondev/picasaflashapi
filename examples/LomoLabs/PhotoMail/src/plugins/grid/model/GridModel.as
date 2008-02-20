/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
import com.bourre.ioc.model.AbstractModel;
import com.bourre.ioc.plugin.IPlugin;

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
		notifyChanged(new PhotoChangedEvent(photos.getNext()));
	}
	
	public function prev():Void
	{
		notifyChanged(new PhotoChangedEvent(photos.getPrevious()));
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