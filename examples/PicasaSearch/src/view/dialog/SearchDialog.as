/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
import be.netdust.visual.containers.ApplicationView;
import be.netdust.visual.containers.HBox;
import be.netdust.visual.containers.Panel;
import be.netdust.visual.object.TextBox;
import be.netdust.visual.object.Button;
import be.netdust.visual.object.Label;
import be.netdust.visual.layout.styles.Style;
import be.netdust.visual.events.*; 

import com.bourre.events.EventType;
import com.bourre.events.StringEvent;

class view.dialog.SearchDialog extends ApplicationView
{	
	//TODO: CleanUp please!
	
	private var __q:String = "Type to search";
	private var __searchPanel:Panel;
	
	public function SearchDialog(aHolder:MovieClip)
	{
		super();
		
		setUI(aHolder.createEmptyMovieClip("app",2));
		decorate();
		
		var tSearchPanel:Panel = getSearchPanel();
			tSearchPanel.onFocus = this.onFocus;
			tSearchPanel.setObserver(this);
		this.addChild(tSearchPanel);

		this.create();

		// Mouse.addListener(this);
		Key.addListener(this);
	}
	
	public function displayResults(aResults:String):Void
	{		
		var tResultLabel:Label = Label(__searchPanel.getChild(1));
			tResultLabel.setLabel(aResults);
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
		__searchPanel.addChild(new Label(" "));
		
		tSearchBox.setObserver(this);
		
		//TODO: 
		// tSearchBox.setFocus();
		
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
	
	private function onKeyDown():Void
	{	
		if(Key.isDown(Key.ENTER)) {
			onClick();
		}
	}

	public function onChanged(e):Void
	{
		__q = e.getTarget().getTextField().text;
	}
	
	private function onFocus(e:BubbleEvent):Void
	{
		var tSource = e.getSource();
		var tHandle = e.getHandle();
	}
	
	private function onClick(e):Void
	{
		displayResults("Searching ...");
		this.dispatchEvent(new StringEvent(new EventType("onStartSearch"),__q));
	}
}