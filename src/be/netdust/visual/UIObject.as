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
import be.netdust.visual.UICore;

class be.netdust.visual.UIObject extends UICore
{
	private var styleClass:String = "UIObject";

	/**
	* @method      UIObject.width
	* @description Returns width of UIObject, in pixels.
	* @usage       <code>UIObject.width:Number;</code> 
	*
	* @return	Number; width of UIObject, in pixels.
	*/
	public function get width():Number {
		return getStyle().width;
	};
	
	/**
	* @method      UIObject.width
	* @description Sets width of UIObject, in pixels.
	* @usage       <code>UIObject.width:Number;</code> 
	*
	* @return	Number; width of UIObject, in pixels.
	*/
	public function set width( w:Number ) {
		getStyle().width = w; 
	};
		
	/**
	* @method      UIObject.height
	* @description Returns height of UIObject, in pixels.
	* @usage       <code>UIObject.height:Number;</code>
	*
	* @return	Number; height of UIObject, in pixels.
	*/
	public function get height():Number {
		return getStyle().height;
	};	
	
	/**
	* @method      UIObject.height
	* @description Sets height of UIObject, in pixels.
	* @usage       <code>UIObject.height:Number;</code> 
	*
	* @return	Number; height of UIObject, in pixels.
	*/
	public function set height( h:Number) {
		getStyle().height = h
	};
	
	/**
	* @method      UIObject.paint
	* @description Paints skin into ui.
	* @usage       <code>UIObject.paint(_ui:MovieClip, _oStyle:Object):Void;</code> 
	*
	*/
	public function paint( ) : Void {
		doLayout( );
		super.paint();
		
	};
	
	/**
	* @method      UIObject.doLayout
	* @description Public method for placing elements of UIObject.
	* @usage       overwrite <code>UIObject.doLayout():Void;</code> 
	*
	*/
	public function doLayout(  ) : Void {
		//
	};
	
	/**
	* private constructor
	* @param style, owner
	*/
	private function UIObject( _styleID ) {
		super( _styleID );
	};
	
	private function setup() {
		super.setup();
		
		if( getStyle().skin ) {
			width = getStyle().minwidth = ui._width;
			height = getStyle().minheight = ui._height;
		};
	};


}