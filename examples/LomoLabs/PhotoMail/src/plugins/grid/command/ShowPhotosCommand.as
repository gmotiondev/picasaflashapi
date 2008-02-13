/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
import com.bourre.ioc.control.AbstractCommand;
import com.bourre.ioc.visual.MovieClipHelperLocator;

import com.bourre.data.libs.LibStack;
import com.bourre.data.libs.GraphicLib;

import plugins.grid.control.ShowPhotosEvent;
import plugins.grid.model.*;
import plugins.grid.view.*;
import plugins.grid.vo.*;

class plugins.grid.command.ShowPhotosCommand extends AbstractCommand
{
	private var __model:GridModel;
	
	public function execute(evt:ShowPhotosEvent)
	{
		__model = GridModel(getModelLocator().getModel(ModelList.GRID_MODEL));
		
		var tThumbsHolder = MovieClipHelperLocator.getInstance(getOwner()).getMovieClipHelper(ViewList.THUMBS_HOLDER);
		var tPhotosHolder = MovieClipHelperLocator.getInstance(getOwner()).getMovieClipHelper(ViewList.PHOTOS_HOLDER);
		
		for(var a:Number = 0; a < __model.photos.length; a++)
		{
			var tItem:sk.prasa.webapis.picasa.Photo = __model.photos[a];
			tThumbsHolder.addChild(tItem.gphoto.id, tItem.media.thumbnail[0].url);
			tPhotosHolder.addChild(tItem.gphoto.id, tItem.media.content.url, tItem.summary);
		}
	}
}