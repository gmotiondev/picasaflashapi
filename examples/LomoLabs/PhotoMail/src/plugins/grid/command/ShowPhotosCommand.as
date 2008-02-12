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
		__model.photos = new Photos();
		
		for(var a:Number = 0; a < evt.photos.length; a++)
		{
			var tPhoto:sk.prasa.webapis.picasa.Photo = evt.photos[a];
			__model.photos.push(tPhoto);
		}
		
		var tThumbsHolder = MovieClipHelperLocator.getInstance(getOwner()).getMovieClipHelper(ViewList.THUMBS_HOLDER);
			//tThumbsHolder.grid = new sk.prasa.visual.layout.GridLayout(6, 6);
			//tThumbsHolder.grid.addListener(tThumbsHolder);
		//var tPhotosHolder = MovieClipHelperLocator.getInstance(getOwner()).getMovieClipHelper(ViewList.PHOTOS_HOLDER);
		//var tTLibStack:LibStack = new LibStack();
		
		for(var a:Number = 0; a < __model.photos.length; a++)
		{
			var tItem:sk.prasa.webapis.picasa.Photo = __model.photos[a];
			tThumbsHolder.addChild(tItem.gphoto.id, tItem.media.thumbnail[0].url, tItem.summary);
			//var tPC:MovieClip = tPhotosHolder.view.createEmptyMovieClip("p_container_"+tItem.gphoto.id, tPhotosHolder.view.getNextHighestDepth());
			//var tTC:MovieClip = tThumbsHolder.view.createEmptyMovieClip("t_container_"+tItem.gphoto.id, tThumbsHolder.view.getNextHighestDepth());
			
			//var tPhoto:Photo = new Photo(getOwner(), tItem.gphoto.id, tPC, true, tItem.media.content.url, tItem.summary);
			//var tThumb:Thumb = new Thumb(getOwner(), tItem.gphoto.id, tTC, tItem.summary);
							
			//tThumbsHolder.grid.addChild(tThumb.view);
			//tThumbsHolder.setTitle(tItem.album.title+" ("+tItem.album.gphoto.numphotos+")");
			
			//__model.addListener(tPhoto);
			//__model.addListener(tThumb);

			//tTLibStack.enqueue(new GraphicLib(tThumb.view, 5), tItem.gphoto.id, tItem.media.thumbnail[0].url);
			//tTLibStack.addListener(tThumbsHolder);
		}
		
		//tTLibStack.execute();
	}
}