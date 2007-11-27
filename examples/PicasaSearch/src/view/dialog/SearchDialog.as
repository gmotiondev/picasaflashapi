/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
import be.netdust.visual.containers.ApplicationView;
import be.netdust.visual.containers.HBox;
import be.netdust.visual.containers.Panel;
import be.netdust.visual.object.TextBox;
import be.netdust.visual.object.Button;
import be.netdust.visual.object.Label;
import be.netdust.visual.object.Description;
import be.netdust.visual.tools.ToolTip;
import be.netdust.visual.layout.styles.Style;
import be.netdust.visual.UICore;
import be.netdust.visual.events.BubbleEvent; 

import com.bourre.commands.Delegate;
import com.bourre.events.EventType;
import com.bourre.events.StringEvent;

class view.dialog.SearchDialog extends ApplicationView
{	
	private var __q:String = "Type to search";
	private var __searchPanel:Panel;
	private var __resultPanel:Panel;
	
	public function SearchDialog(aHolder:MovieClip)
	{
		super();
		
		setUI(aHolder.createEmptyMovieClip("app",2));
		decorate();
		
		this.addChild(getSearchPanel());
		this.create();			
	}
	
	private function decorate():Void
	{
		var tTextAreaStyle:Style = Style.getStyle("TextBox");
			tTextAreaStyle.setFormat("fu", {font:"Tahoma", multiLine: false, size:18, color: 0x000000, bold:false, underline:false });
	}
	
	private function getSearchPanel():Panel
	{
		__searchPanel.destroy();
		__searchPanel = new Panel("Search picasaweb");

		var tSearchBox:TextBox = new TextBox(__q);
			tSearchBox.width = 300;
			tSearchBox.height = 28;
			
		var tSubmitButton:Button = new Button("Search");
			tSubmitButton.addEventListener(new EventType("onClick"),this);

		var tHBox:HBox = new HBox();
			tHBox.addChild(tSearchBox);
			tHBox.addChild(tSubmitButton);
			
		__searchPanel.addChild(tHBox);
		
		Mouse.addListener(this);
		Key.addListener(this);

		return __searchPanel;
	}

	private function onMouseDown():Void
	{
		if(__searchPanel.getUI().hitTest(_root._xmouse,_root._ymouse,true))
		{
			this.getUI().startDrag();
		}
	}
	
	private function onMouseUp():Void
	{
		this.getUI().stopDrag();
	}
	
	private function onKeyDown(e)
	{	
		if(Key.isDown(Key.ENTER))
		{
			trace("enter !");
		}
	}

	public function onFocus(e):Void
	{
		trace("got focus!")
	}
	
	private function onClick(e):Void
	{
		this.dispatchEvent(new StringEvent(new EventType("onStartSearch"),__q));
		
	}
}