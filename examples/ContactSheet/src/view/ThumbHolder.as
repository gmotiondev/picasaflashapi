import com.bourre.visual.MovieClipHelper;
import com.bourre.events.IEvent;
import com.bourre.log.PixlibStringifier;

/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
class view.ThumbHolder extends MovieClipHelper
{	
	/**
	 * Constructor 
	 */
	public function ThumbHolder(aId:String,aC:MovieClip)
	{
		super(aId,aC);
		initialize();
	}
	
	/**
	 * initialize point	 */
	private function initialize()
	{
		show();
		centerize();
	}
	
	/**
	 * set title
	 */
	public function setTitle(a:String):Void
	{			
		var tTF:TextFormat = new TextFormat();
			tTF.font = "kroeger";
			tTF.size = 8;
			tTF.color = 0x808080;
			
		view.createTextField("tf_album_title", 2, 0, -20, 320, 20);
		var tF:TextField = view["tf_album_title"];
			tF.embedFonts = true;
			tF.html = true;
			tF.htmlText = a;
			tF.setTextFormat(tTF);
	}
	/**
	 * centerize holder	 */
	private function centerize():Void
	{
		move(Math.round(Stage.width/2 - view._width/2), Math.round(Stage.height/2 - view._height/2));
	}
	
	/**
	 * Listening to model	 */
	public function onResize(e:IEvent):Void
	{
		centerize();
	}
	
	/**
	 * Listening to Layout Manager	 */
	public function complete(e:IEvent):Void
	{
		centerize();
	}
	
	/**
	 *	pixlib 
	 */	
	public function toString():String 
	{
		return PixlibStringifier.stringify(this);
	}
}
