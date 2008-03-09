
import be.netdust.visual.layout.skins.UIBorder;
import be.netdust.visual.layout.styles.Style;

import com.bourre.commands.Delegate;
import com.bourre.commands.CommandMS;

class be.netdust.visual.tools.ToolTip 
{

	public var styleClass:String = "ToolTip";
	
	public var showTime:Number = 800;
	public var hideTime:Number = 6400;
	
	/**
	* @method      ToolTip.active
	* @description Getter method for check if hint visible.
	* @usage       <code>ToolTip.active:Boolean; </code>
	*
	* @return   Boolean; true if hint visible.
	*/
	public function get active() : Boolean {
		if(current != -1){
			return true;
		} else {
			return false;
		}
	};
	
	
	/**
	* @method      ToolTip.width
	* @description Getter method for the TextField object width properties.
	* @usage       <code>ToolTip.width:Number; </code>
	*
	* @return   Number; width of TextField.
	*/
	public function get width():Number {
		return message_txt._width;
	}
	
	/**
	* @method      ToolTip.height
	* @description Getter method for the TextField object height properties.
	* @usage       <code>ToolTip.height:Number; </code>
	*
	* @return  Number; height of TextField.
	*/
	public function get height():Number {
		return message_txt._height;
	}
	
	/*
	* Constructor
	*/
	public function ToolTip( ) 
	{
		_cTimerCommand = new CommandMS();
		init( );
	}
	
	/**
	* @method      ToolTip.switchOn
	* @description Resolves display of hints.
	* @usage       <code>ToolTip.switchOn():Void;</code>
	*/
	public function switchOn():Void 
	{
		container_mc.onMouseMove = Delegate.create( this, _checkMouseHit )
	}
	
	/**
	* @method      ToolTip.switchOff
	* @description Forbids display of hints.
	* @usage       <code>ToolTip.switchOff():Void;</code>
	*/
	public function switchOff():Void 
	{
		delete container_mc.onMouseMove;
		hide();
	}
	
	/**
	* @method      ToolTip.addElement
	* @description Adds element.
	* @usage       <code>ToolTip.addElement(el:Object, mes:String):Number;</code>
	*
	* @param  el   (Object) object for which will arise a hint.
	* @param  mess (String) text of hint.
	*
	* @return   Number; index of added element.
	*/
	public function addElement(element:Object, message:String):Number 
	{
		_aElements.push(element); 
		_aMessage.push(message); 

		return (_aElements.length - 1);
	}
	
	/**
	* @method      ToolTip.removeElement
	* @description Remove element.
	* @usage       <code>ToolTip.removeElement(id:Number):Void;</code>
	*
	* @param  id   (Number) index of element in array.
	*/
	public function removeElement(id:Number):Void 
	{
		_aElements.splice(id, 1);
		_aMessage.splice(id, 1); 
	}
	
	/**
	* @method      ToolTip.show
	* @description Public method to show tool tip.
	* @usage       <code>ToolTip.show(str:String):Void; </code>
	*
	* @param   m   (String) text of hint.
	* @param   d   (Number) duration of display.
	*/
	public function show(m:String, d:Number):Void {
		d = d != undefined ? d : hideTime;
		drawTip(m, d);
	}
	
	/**
	* @method      ToolTip.hide
	* @description Method to hide tool tip.
	* @usage       <code>ToolTip.hide():Void; </code>
	*/
	public function hide():Void {
		_cTimerCommand.removeAll();
		container_mc._visible = false;
	}
	
	/**
	* @method      ToolTip.setup
	* @description Creates containers for tooltip.
	* @usage       <code>ToolTip.setup( target:MovieClip, depth:Number ):Void;</code>
	*/	
	public function setup( target:MovieClip ):Void 
	{
		container_mc = target.createEmptyMovieClip("tooltip_mc", target.getNextHighestDepth() );
		container_mc._visible = false;		
		makeTextField();		
		switchOn()
	}
	
	/**
	* @method      ToolTip.init
	* @description initializes tooltip.
	* @usage       <code>ToolTip.init():Void;</code>
	*/	
	private function init( ):Void 
	{
		_aMessage = new Array();		
		_aElements = new Array();	
		__skin = Style.getStyle( styleClass );

		_txtformat = new TextFormat( __skin.getFormat("fu").font, __skin.getFormat("fu").size, __skin.getFormat("fu").color );
	}
	
	private function _checkMouseHit()
	{
		var onOver:Boolean = false;
		var o:Object = new Object(); // to converts local coordinates to global

		for(var i:Number = 0; i < _aElements.length; i++) {
			o.x = container_mc._xmouse;
			o.y = container_mc._ymouse;
    		container_mc.localToGlobal(o);

			if(_aElements[i].ui.hitTest(o.x, o.y, false))
			{		
				if(current != i)
				render(i);

				onOver = true;
				continue;
			}
		}
			
		if(!onOver)
		hide();
	}
	
	/**
	* @method      ToolTip.render
	* @description Private method to show tool tip.
	* @usage       <code>ToolTip.render(i:Number):Void; </code>
	*
	* @param  i    (Number) index of element in _aElements.
	*/
	private function render(i:Number):Void {
		current = i;
		_cTimerCommand.delay( new Delegate( this, drawTip, _aMessage[current], hideTime ), showTime );
	}
	
	/**
	* @method      ToolTip.drawTip
	* @description Method called by 'render' using CommandMS or by 'show' to show tooltip.
	* @usage       <code>ToolTip.drawTip(str:String):Void; </code>
	*
	* @param  str  (String) value for ToolTip text.
	*/
	private function drawTip(str:String, delay:Number):Void 
	{
		delay = delay != undefined ? delay : 0;
		container_mc._visible = true;		
		message_txt.text = str;

		drawBack();
		setpos();

		if(delay != 0)
		_cTimerCommand.delay( new Delegate( this, hide ), delay );
	}
	

	/**
	* @method      ToolTip.makeTextField
	* @description Creates textField.
	* @usage       <code>ToolTip.makeTextField():Void; </code>
	*/
	private function makeTextField():Void
	{
		container_mc.createTextField("textField", 7, __skin.marginLeft, __skin.marginTop, 100, 10);
		message_txt = container_mc.textField;
		
		message_txt.html = true;
		message_txt.autoSize = "left";
		message_txt.multiline  = true;
		message_txt.selectable = false;
		//message_txt.embedFonts = __skin.embedFonts;
		message_txt.setNewTextFormat( _txtformat );
	}
	

	/**
	* @method      ToolTip.drawBack
	* @description Draws background.
	* @usage       <code>ToolTip.drawBack():Void; </code>
	*/
	private function drawBack():Void {
		backWidth = width + __skin.hmargin;
		backHeight = height + __skin.vmargin;		

		UIBorder.getInstance().draw( container_mc, backWidth, backHeight, __skin)
	}
	
	/**
	* @method      ToolTip.setpos
	* @description Position method for container_mc.
	* @usage       <code>ToolTip.setpos(x:Number, y:Number):Void; </code>
	*
	* @param    x  (Number) value for x.
	* @param    y  (Number) value for y.
	*/
	private function setpos():Void 
	{
		var x, y : Number = 0;
		
		if ((_root._xmouse + backWidth) >= Stage.width && (_root._ymouse + backHeight+18) >= Stage.height){
			x = _root._xmouse-(backWidth+5);
			y = _root._ymouse - (backHeight+5);
		} else if ((_root._xmouse + backWidth) >= Stage.width){
			x = _root._xmouse-(backWidth+5);
			y = _root._ymouse + 18;
		} else if ((_root._ymouse + backHeight+18) >= Stage.height){
			x = _root._xmouse;
			y = _root._ymouse - (backHeight+5);
		} else {
			x = _root._xmouse + 18
			y = _root._ymouse + 18;
		}
		
		container_mc._x = x;
		container_mc._y = y;
	}
		

	private var backWidth:Number;
	private var backHeight:Number;

	private var current:Number;
	
	private var _aMessage:Array;
	private var _aElements:Array; 
	
	private var container_mc:MovieClip; 
	private var message_txt:TextField;
	
	private var __skin:Style = null;
	private var _txtformat:TextFormat
	
	private var _cTimerCommand:CommandMS;
}
