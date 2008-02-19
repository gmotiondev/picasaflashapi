/** * Copyright (c) 2007 Stefan Vandermeulen - netdust.be 
 * 
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */
import be.netdust.visual.UIObject;

class be.netdust.visual.object.Label extends UIObject implements be.netdust.visual.managers.IFocus
{
	public var styleClass:String = "Label";
	
	public function Label( _sValue:String, _styleID ) {
		super( _styleID );	
		setLabel( _sValue );
	};

	public function setLabel( val:String ) 
	{
		super.setLabel( val );
		_labeltf.text = getLabel();
		_labeltf.autoSize = "left";	
	};
	
	public function getLabel() : String
	{		
		return label!=null?label:"";
	};
	
	public function getText():String
	{
		return _labeltf.text;
	}
	
	public function setFocus () : Void
	{
		_focus = Selection.setFocus( _labeltf );
		Selection.setSelection( 0, _labeltf.text.length );
	}
	
	public function killFocus() : Void
	{
		_focus = false;
	}
	
	public function hasFocus () : Boolean
	{
		return _focus;		
	}
	
	/**
	* @method      _labeltf.doLayout()
	* @description Completes layout of instance, called after paint
	* @usage       <code>_labeltf.doLayout():Void;</code> 
	*/
	public function doLayout() : Void
	{
		super.doLayout()

		_labeltf.text = getLabel();
		_labeltf.autoSize = "left";	

		width = _labeltf._width + getStyle().hpadding + getStyle().hborder;
		height = _labeltf._height + getStyle().vpadding + getStyle().vborder;
	};
	

	
	private function setup() {
		super.setup();
		
		if( ui.label!=undefined ) _labeltf = ui.label
		else {
			ui.createTextField( "label", 1 , getStyle().paddingLeft, getStyle().paddingTop, width - getStyle().paddingLeft, height - getStyle().paddingBottom );	
			_labeltf = ui.label;
			_labeltf.setNewTextFormat( getStyle().getFormat("fu") );
			_labeltf.embedFonts = getStyle().embedFonts;
			_labeltf.selectable = false;	
			_labeltf.multiline = false;
			_labeltf.wordWrap = false;			
		
		};
		
		if( _focusInstance ) callObserver("onRegisterFocus");
		
		
		//_labeltf.onKillFocus = Delegate( this, killFocus );
	}

	private var _focus:Boolean;
	private var _labeltf:TextField = null;
	private var _hasFocus:Boolean = false;
	private var _focusInstance:Boolean = false;
}