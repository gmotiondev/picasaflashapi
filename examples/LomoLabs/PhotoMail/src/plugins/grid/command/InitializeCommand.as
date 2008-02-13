/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
import com.bourre.ioc.control.AbstractCommand;
import com.bourre.ioc.visual.MovieClipHelperLocator;

import com.bourre.data.libs.LibStack;
import com.bourre.data.libs.GraphicLib;

import plugins.grid.control.*;
import plugins.grid.model.*;
import plugins.grid.view.*;
import plugins.grid.vo.*;

class plugins.grid.command.InitializeCommand extends AbstractCommand
{
	private var __model:GridModel;
	
	public function execute(evt:InitializeEvent)
	{
		__model = GridModel(getModelLocator().getModel(ModelList.GRID_MODEL));
		__model.photos = new Photos();
		
		for(var a:Number = 0; a < evt.photos.length; a++)
		{
			var tPhoto:sk.prasa.webapis.picasa.Photo = evt.photos[a];
			__model.photos.push(tPhoto);
		}
		
		getOwner().firePrivateEvent(new ShowPhotosEvent(getOwner()));
	}
}