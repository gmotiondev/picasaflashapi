/**
 * @author michal.gron@gmail.com
 */
import com.bourre.visual.MovieClipHelper;
import com.bourre.visual.ScreenProtectionUI 
import com.bourre.data.libs.LibEvent;
import com.bourre.data.libs.ILibListener;
import com.bourre.data.libs.LibStack;
import com.bourre.data.libs.GraphicLib;
import com.bourre.utils.Geom;

class sk.prasa.visual.object.AbstractPhoto extends MovieClipHelper implements ILibListener
{
	private var id:String;
	private var url:String;
	private var title:String;
	private var loaded:Boolean = false;
	private var __background:MovieClip;
	
	public function AbstractPhoto(aId:String, aContainer:MovieClip, aHide:Boolean, aUrl:String, aTitle:String)
	{
		super(aId, aContainer);
		
		id = aId;
		url = aUrl;
		title = aTitle;
		
		setVisible(!aHide);
	}
	
	private function setBackground(aColor:Number, aHighlight:Number, aMargin:Number):Void
	{
		var tTopbar:Number = 15;
		
		__background = Geom.buildRectangle(view, 4, (view._width+(2*aMargin)), (view._height+(2*aMargin) + tTopbar), aColor, aColor);
		__background._x = -aMargin;
		__background._y = -aMargin - tTopbar;
		__background.__c = aColor;
		__background.__h = aHighlight;
	}
	
	private function setTitle():Void
	{
		var tTF:TextFormat = new TextFormat();
			tTF.font = "kroeger";
			tTF.size = 8;
			tTF.color = 0xd40073;
			
		view.createTextField("title_tf", 15, 0, -20, 1, 1);
		var tF:TextField = view.title_tf;
			tF.embedFonts = true;
			tF.autoSize = "left";
			tF.html = true;
			tF.htmlText = title;
			tF.setTextFormat(tTF);
	}
	
	private function protect():Void
	{
		var tProtection:MovieClipHelper = new ScreenProtectionUI(_level0,6,"protection");
			tProtection.view._alpha = 20;
	}
	
	private function unprotect():Void
	{
		var tProtection:MovieClipHelper = MovieClipHelper.getMovieClipHelper("protection");
			tProtection.release();
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