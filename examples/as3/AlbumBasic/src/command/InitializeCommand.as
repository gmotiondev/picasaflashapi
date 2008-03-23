package command 
{
	import flash.display.Sprite;	
	import flash.display.DisplayObject;	
	
	import view.thumb.Thumb;	
	
	import flash.net.URLRequest;	
	
	import sk.prasa.webapis.picasa.Photo;	
	
	import flash.display.DisplayObjectContainer;	
	
	import com.bourre.load.GraphicLoader;	
	import com.bourre.load.QueueLoader;	
	
	import view.ViewList;	
	
	import com.bourre.view.ViewLocator;	
	
	import view.thumb.ThumbsHolder;	
	
	import model.ModelList;	
	
	import com.bourre.model.ModelLocator;	
	
	import model.ModelApplication;	
	
	import flash.events.Event;	
	
	import com.bourre.commands.Command;
	import com.bourre.commands.AbstractCommand;	
	
	import control.InitializeEvent;

	import sk.prasa.webapis.picasa.GPhoto;
	import sk.prasa.webapis.picasa.Media;	
	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 */
	
	public class InitializeCommand extends AbstractCommand implements Command 
	{
		private var __model : ModelApplication;

		override public function execute(evt : Event = null) : void
		{
			__model = ModelApplication(ModelLocator.getInstance().getModel(ModelList.MODEL_APPLICATION));
			 
			var tThumbsHolder : ThumbsHolder = ThumbsHolder(ViewLocator.getInstance().getView(ViewList.THUMBS_HOLDER));
			var tQueue : QueueLoader = new QueueLoader();
			 
			for each(var item : Photo in __model.photos)
			{
				var tThumb : Sprite = tThumbsHolder.addChild(new Thumb()) as Sprite;
				var tGL : GraphicLoader = new GraphicLoader(tThumb);
					tGL.addListener(tThumbsHolder);
				//				tQueue.add(new GraphicLoader(tThumbsHolder.view as DisplayObjectContainer), item.gphoto.id, new URLRequest(item.media.thumbnail[0].url));				tQueue.add(tGL, item.gphoto.id, new URLRequest(item.media.thumbnail[0].url));
			}
			
			tQueue.run();
		}
	}
}
