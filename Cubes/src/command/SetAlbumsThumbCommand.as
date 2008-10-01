import com.bourre.commands.Command;
import com.bourre.core.Model;
import com.bourre.data.iterator.Iterator;
import com.bourre.data.libs.GraphicLib;
import com.bourre.data.libs.LibStack;
import com.bourre.visual.MovieClipHelper;

import control.SetAlbumsThumbEvent;

import model.ModelApplication;
import model.ModelList;

import sk.prasa.webapis.picasa.Album;

import view.UserView;
import view.ViewList;

/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
class command.SetAlbumsThumbCommand implements Command
{
	private var model : ModelApplication;

	public function execute(evt : SetAlbumsThumbEvent) : Void
	{
		model = ModelApplication(Model.getModel(ModelList.MODEL_APPLICATION));

		//var tMainView : MainView = MainView(MovieClipHelper.getMovieClipHelper(ViewList.MAIN_VIEW));
		var tUserView : UserView = UserView(MovieClipHelper.getMovieClipHelper(ViewList.USER_VIEW));
			tUserView.setupGrid(model.albums.length);
		//var tDisplay : AlbumDisplay = tMainView.addAlbumDisplay(ViewList.ALBUM_DISPLAY, model.albums.length);
			
		var tIterator : Iterator = model.albums.getIterator();
		var tLibStack : LibStack = new LibStack();
			tLibStack.addListener(tUserView);
			
		while(tIterator.hasNext())
		{
			var tItem : Album = tIterator.next();
			var tChild : MovieClip = tUserView.getChildContainer(tItem.gphoto.id);
			
			tLibStack.enqueue(new GraphicLib(tChild, 2), tItem.gphoto.id, tItem.media.thumbnail[0].url);
		}
		
		tLibStack.execute();
	}
}