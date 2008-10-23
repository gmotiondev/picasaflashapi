package command 
{
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.system.LoaderContext;
	
	import com.bourre.commands.AbstractCommand;
	import com.bourre.commands.Command;
	import com.bourre.load.GraphicLoader;
	import com.bourre.load.QueueLoader;
	import com.bourre.model.ModelLocator;
	import com.bourre.view.ViewLocator;
	
	import model.ModelApplication;
	import model.ModelList;
	
	import sk.prasa.webapis.picasa.objects.GPhoto;
	import sk.prasa.webapis.picasa.objects.Media;
	import sk.prasa.webapis.picasa.objects.feed.PhotoEntry;
	
	import view.ViewList;
	import view.photo.PhotosHolder;
	import view.thumb.Thumb;
	import view.thumb.ThumbsHolder;		
	
	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 * 
	 */
	public class InitializeCommand extends AbstractCommand implements Command 
	{
		private var __model : ModelApplication;

		override public function execute(evt : Event = null) : void
		{
			__model = ModelApplication(ModelLocator.getInstance().getModel(ModelList.MODEL_APPLICATION));
			 
			var tThumbsHolder : ThumbsHolder = ThumbsHolder(ViewLocator.getInstance().getView(ViewList.THUMBS_HOLDER));
			var tPhotosHolder : PhotosHolder = PhotosHolder(ViewLocator.getInstance().getView(ViewList.PHOTOS_HOLDER));
			
			var tQueue : QueueLoader = new QueueLoader();
			
			for each(var item : PhotoEntry in __model.photos)
			{
				var tThumb : view.thumb.Thumb = new view.thumb.Thumb(item.gphoto.id, item.summary);
					tThumbsHolder.addChild(tThumb);
				var tPhoto : view.photo.Photo = new view.photo.Photo(item.gphoto.id);
					tPhotosHolder.addChild(tPhoto);
					
				var tGL : GraphicLoader = new GraphicLoader(tThumb);
					tGL.addListener(tThumbsHolder);				
				tQueue.add(tGL, item.gphoto.id, new URLRequest("http://prasa.sk/image.php?image="+item.media.thumbnails[0].url), new LoaderContext(true));
			}
			
			tQueue.run();
			
			__model.next();	// load first photo;
		}
	}
}
