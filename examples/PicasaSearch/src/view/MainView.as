/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
import com.bourre.visual.MovieClipHelper;
import be.netdust.visual.containers.ApplicationView;
import be.netdust.visual.containers.HBox;
import be.netdust.visual.containers.Panel;
import be.netdust.visual.object.TextBox;
import be.netdust.visual.object.Button;
import be.netdust.visual.object.Label;
import be.netdust.visual.layout.styles.Style;

import com.bourre.commands.Delegate;
import com.bourre.events.EventType;
import com.bourre.events.EventBroadcaster;

import control.*;

class view.MainView extends MovieClipHelper
{
	private var __q:String = "Type to search";
	
	public function MainView(aID:String, aContainer:MovieClip)
	{
		super(aID, aContainer);
		
		initialize();
		centerize();
	}
	
	private function initialize():Void
	{			 
		var tAppView:ApplicationView = new ApplicationView();
			tAppView.setUI(view.createEmptyMovieClip("appholder",2));
		var tPanel:Panel = new Panel("Search picasaweb");
		var tHBox:HBox = new HBox();

		var tSearchBox:TextBox = new TextBox(__q);
			tSearchBox.width = 300;
			tSearchBox.height = 28;
		
		
		var tTextAreaStyle:Style = Style.getStyle("TextBox"); 
			tTextAreaStyle.setFormat("fu", {font:"Tahoma", multiLine: false, size:18, color: 0x000000, bold:false, underline:false });
			
		var tSubmitButton:Button = new Button("Search");
			tSubmitButton.addEventListener(new EventType("onClick"),this);

			tHBox.addChild(tSearchBox);
			tHBox.addChild(tSubmitButton);
			tPanel.addChild(tHBox)
			tAppView.addChild(tPanel);
			tAppView.create();
			
			tSearchBox.setFocus();
			tSearchBox.getUI().label.onChanged = Delegate.create(this,onChanged);
			
			tPanel.getUI().onMouseDown = function()
			{
				if(this.header.hitTest(_root._xmouse,_root._ymouse,true))
				{
					this.startDrag();
				}
			}
			tPanel.getUI().onMouseUp = function()
			{
				this.stopDrag();
			}
	}
	
	private function onNoneFound(e):Void
	{
		var tAppView:ApplicationView = new ApplicationView();
			tAppView.setUI(view.createEmptyMovieClip("nonefoundholder",3));
		
		var tLabel:Label = new Label("None found!");
		var tOKButton:Button = new Button("OK");
		
			tAppView.addChild(tLabel);
			tAppView.addChild(tOKButton);
			
			tAppView.create();
	}
	
	private function onClick(e):Void
	{
		EventBroadcaster.getInstance().dispatchEvent(new GetPhotosEvent(escape(__q)));
	}
	
	private function onChanged(e):Void
	{
		__q = e.text;
	}
	
	private function centerize():Void
	{
		move(Math.round(Stage.width/2 - view._width/2), Math.round(Stage.height/2 - view._height/2));
	}
}
