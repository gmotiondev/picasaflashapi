/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
import com.bourre.visual.MovieClipHelper;
import com.bourre.data.libs.LibEvent;
import com.bourre.data.libs.ILibListener;
import com.bourre.data.libs.LibStack;
import com.bourre.data.libs.GraphicLib;

class view.Photo extends MovieClipHelper implements ILibListener
{
	private var id:String;
	private var url:String;
	private var loaded:Boolean = false;
	
	public function Photo(aId:String, aContainer:MovieClip, aUrl:String)
	{
		super(aId, aContainer);
		
		id = aId;
		url = aUrl;
		
		load();
	}
	
	private function load():Void
	{
		var tLibStack:LibStack = new LibStack();
		
		tLibStack.enqueue(new GraphicLib(view, 5), id, url);
		tLibStack.addListener(this);
		tLibStack.execute();
	}
	
	public function onLoadInit(e:LibEvent):Void
	{
		loaded = true;
	}
	
	public function onLoadProgress(e:LibEvent):Void
	{
	}
	
	public function onLoadComplete(e:LibEvent):Void
	{
	} 
	
	public function onTimeOut(e:LibEvent):Void
	{
		trace("ERROR: Photo loading time out: "+e.getName());
	}
}