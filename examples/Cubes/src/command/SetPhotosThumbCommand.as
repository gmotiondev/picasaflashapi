import com.bourre.commands.Command;
import com.bourre.core.Model;
import com.bourre.data.collections.IndexedArray;
import com.bourre.data.iterator.Iterator;
import com.bourre.data.libs.GraphicLib;
import com.bourre.data.libs.LibStack;
import com.bourre.visual.MovieClipHelper;

import control.*;

import model.*;

import sk.prasa.webapis.picasa.Album;

import view.*;

/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
class command.SetPhotosThumbCommand implements Command
{
	private var model : ModelApplication;

	public function execute(evt : SetPhotosThumbEvent) : Void
	{
		model = ModelApplication(Model.getModel(ModelList.MODEL_APPLICATION));
		
		var tPhotos : IndexedArray = model.photos.getPhotosByAlbumId(evt.albumid);
		
		var tApp : Application = Application(MovieClipHelper.getMovieClipHelper(ViewList.APPLICATION));
		var tAlbumView : AlbumView = new AlbumView(evt.albumid, tApp.view.createEmptyMovieClip(evt.albumid, tApp.view.getNextHighestDepth()));
			tAlbumView.setupGrid(tPhotos.length);
		
		model.addListener(tAlbumView);
		
		var tIterator : Iterator = tPhotos.getIterator();
		var tLibStack : LibStack = new LibStack();
			tLibStack.addListener(tAlbumView);
			
		while(tIterator.hasNext())
		{
			var tItem : Album = tIterator.next();
			var tChild : MovieClip = tAlbumView.getChildContainer(tItem.gphoto.id);
			
			tLibStack.enqueue(new GraphicLib(tChild, 2), tItem.gphoto.id, tItem.media.thumbnail[0].url);
		}
		
		tLibStack.execute();
	}
}