﻿/**
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
		var tId:String = photos.getNext();
		var tSum:String = photos.getCurrentTitle();

		notifyChanged(new PhotoChangedEvent(tId, tSum));
	}
	
	public function prev():Void
	{
		var tId:String = photos.getPrevious();
		var tSum:String = photos.getCurrentTitle();
		
		notifyChanged(new PhotoChangedEvent(tId, tSum));
	}
	
	public function click(aId:String):Void
	{
		var tId:String = photos.getClicked(aId);
		var tSum:String = photos.getCurrentTitle();
		
		notifyChanged(new PhotoChangedEvent(tId, tSum));
	}
	
	public function onResize():Void
	{
		notifyChanged(new ResizeEvent(getOwner()));
	}
}