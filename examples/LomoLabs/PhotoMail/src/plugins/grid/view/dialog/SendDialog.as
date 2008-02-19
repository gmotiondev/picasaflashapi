/**
 * @author Michal Gron (michal.gron@gmail.com)
 */

import com.bourre.ioc.visual.AbstractMovieClipHelper;
import com.bourre.ioc.plugin.IPlugin;

import com.bourre.commands.Delegate;
import com.bourre.events.EventType;

import plugins.grid.control.PhotoSendEvent;
import plugins.grid.control.dialog.GetSendDialogEvent;

import be.netdust.visual.assembler.ViewBuilder
import be.netdust.visual.containers.*;
import be.netdust.visual.object.*;

class plugins.grid.view.dialog.SendDialog extends AbstractMovieClipHelper
{
	// just to get the classes included!
	private var __app:ApplicationView;
	private var __panel:Panel;
	private var __textarea:TextArea;
	private var __textbox:TextBox;
	private var __vbox:VBox;
	private var __hbox:HBox;
	private var __button:Button;
	private var __deck:DeckBox;
	// 
	
	private var __id:String;
	private var __summary:String;
	
	private var __vb:ViewBuilder;
	
	public function SendDialog(owner:IPlugin, name:String, mc:MovieClip, summary:String)
	{
		super(owner, "send_dialog_"+name, mc);
		
		__id = name;
		__summary = summary;
		
		initialize();
	}
	
	public function setDialog(aId:String):Void
	{
		show();
		view._xscale = 100;
		
		var tDeck:DeckBox = __vb.getChildByID("deck");
			tDeck.show(aId);
	}
	
	public function setResult(aMessage:String):Void
	{
		var tTextBox:TextBox = __vb.getChildByID("result_message");
			tTextBox.setLabel(tTextBox.getLabel()+aMessage);
	}
	
	private function initialize():Void
	{	
		var tXml:XML = new XML('<?xml version="1.0"?>'+
			'<beans>' +
			'	<view id="main">' +
			'		<Panel id="dialog_panel" label="Send to friend">' +
			'			<DeckBox id="deck" selectedIndex="1">' +
			'				<VBox id="send">' +
			'					<TextArea id="desc" label="'+__summary+'" width="300" height="100"/>' +
			'					<TextBox id="from" label="from@you.com" width="300"/>' +
			'					<TextBox id="to" label="to@someone.com" width="300"/>' +
			'					<HBox>' +
			'						<Button id="send_button" label="Send"/>' +
			'						<Button id="close_button" label="Close"/>' +
			'					</HBox>' +
			'				</VBox>' +
			'				<VBox id="sending">' +
			'					<Label label="Sending email"/>' +
			'				</VBox>' +
			'				<VBox id="sent">' +
			'					<Label id="result_message" label="Sent: "/>' +
			'					<Button id="close_button_sent" label="Close"/>' +
			'				</VBox>' +
			'			</DeckBox>' +
			'		</Panel>' +
			'	</view>' +
			'</beans>');
			
		__vb = new ViewBuilder();
		__vb.addListener(this)
		__vb.parseExternal(tXml);
	}
	
	private function onViewInit():Void
	{
		__vb.register(view);
		
		var tSendListener:Object = {onClick:Delegate.create(this, onSend)};
		var tCloseListener:Object = {onClick:Delegate.create(this, onClose)};
			
		var tSendButton:Button = __vb.getChildByID("send_button");
			tSendButton.addEventListener(new EventType("onClick"), tSendListener); 
		
		var tCloseButton:Button = __vb.getChildByID("close_button");
			tCloseButton.addEventListener(new EventType("onClick"), tCloseListener);
			
		var tCloseButtonSent:Button = __vb.getChildByID("close_button_sent");
			tCloseButtonSent.addEventListener(new EventType("onClick"), tCloseListener);
	}
		
	private function onSend():Void
	{
		var tFrom:String = __vb.getChildByID("from").getText();
		var tTo:String = __vb.getChildByID("to").getText();
		var tDesc:String = __vb.getChildByID("desc").getText();
		
		getOwner().firePrivateEvent(new PhotoSendEvent(getOwner(), tFrom, tTo, tDesc, __id));
	}
	
	private function onClose():Void
	{
		hide();
		view._xscale = 0;
		
		getOwner().firePrivateEvent(new GetSendDialogEvent(getOwner(), null));
	}
}