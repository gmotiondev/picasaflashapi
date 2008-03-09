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
import be.netdust.visual.layout.styles.Style;
import be.netdust.visual.UIContainer;

class be.netdust.visual.containers.TitleBox 
extends UIContainer 
{
	public var styleClass:String = "TitleBox";
	private var _labeltf:TextField;
	
	/*
	* Constructor.
	*/
	public function TitleBox( _label:String, _styleID )
	{
		super( _styleID );	
		setLabel( _label );
	}
	
	public function paint()
	{
		super.paint();
		_skin.draw( _linemask, _labeltf._width + _labelstyle.paddingRight + getStyle().paddingLeft, _labelstyle.height, _lineMaskStyle )
	}
	/**
	* @method      UIContainer.doLayout()
	* @description Public method for placing elements of container.
	* @usage       <code>UIContainer.doLayout():Void;</code> 
	*/
	public function doLayout():Void 
	{
		super.doLayout();	

		_labeltf.text = getLabel();
		_labeltf.autoSize = "left";
		
		_labeltf._x = _labelstyle.paddingLeft;
		_labeltf._y = -_labeltf._height/2;		
		
		_linemask._x = _labelstyle.paddingLeft - getStyle().paddingLeft;
		_linemask._y = -getStyle().borderTopWidth;
	}
	
	
	/**
	* @method      TitleBox.setup
	* @description setup of TitleBox.
	* @usage       <code>TitleBox.setup():Object;</code> 
	*/
	private function setup():Void 
	{
		super.setup();			
		if( ui.label!=undefined ) _labeltf = ui.label
		else {
			_linemask = ui.createEmptyMovieClip("linemask", 1 );
			ui.createTextField( "label", 2 , 0, 0, _labelstyle.width, _labelstyle.height );	
			_labeltf = ui.label;
			_labeltf.setNewTextFormat( _labelstyle.getFormat("fu") );
			_labeltf.embedFonts = getStyle().embedFonts;
		};		
	};
	
	/**
	* @method      TitleBox.init
	* @description Initialization of TitleBox.
	* @usage       <code>TitleBox.init():Void;</code> 
	*/
	private function init():Void
	{
		super.init();		
		setFlex( true );
		layoutmanager.setDirection( "vertical" );
		
		_lineMaskStyle = getStyle().subStyle("linemask", true );
		_lineMaskStyle.borderBottomAlpha = 0;
		_lineMaskStyle.borderTopAlpha = 0; 
		_lineMaskStyle.borderRightAlpha = 0; 
		_lineMaskStyle.borderLeftAlpha = 0;
		
		_labelstyle = getStyle().getSubStyle("label");

	}
	private var _lineMaskStyle:Style;
	private var _labelstyle:Style
	
	private var _linemask:MovieClip;
	private var _flex:Boolean = true;
}