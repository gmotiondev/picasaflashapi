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

  /* use this class for component's on stage or in the library */
import be.netdust.visual.layout.skins.AbstractSkin;
import be.netdust.visual.layout.skins.ISkin;
class be.netdust.visual.layout.skins.UISprite
extends AbstractSkin
{

	/**
	* @method      AbstractSkin.getInstance
	* @description Singleton access to AbstractSkin class.
	* @usage       <code> AbstractSkin.getInstance():Void;</code> 
	*/
	public static function getInstance():ISkin {
		if( _oI==null) _oI = new UISprite();
		
		return _oI;
	}
	
	/**
	* @method      UISprite.init
	* @description Initialize skins.
	* @usage       <code>UISprite.init(t:MovieClip, d:Number, i:String):MovieClip;</code> 
	*
	* @param    t  (MovieClip) movie clip for drawing.
	* @param    d  (Number) depth of new instance.
	* @param    i  (String) instance linkage id.
	* 
	* @return   newly created movieclip
	*/		
	public function init( t:MovieClip, d:Number, i:String  ) : MovieClip {
		var ui:MovieClip = null;
		
		ui = t.attachMovie( i, i+"_"+d, d );
		if( ui == undefined ) {
			ui = t.createEmptyMovieClip(  i+"_"+d, d );
		};

		return ui;
	}
	
	/**
	* @method      UISprite.draw
	* @description Draws skins.
	* @usage       <code>UISprite.draw(t:MovieClip, w:Number, h:Number, p:Object):Void;</code> 
	*
	* @param    t  (MovieClip) movie clip for drawing.
	* @param    w  (Number) width.
	* @param    h  (Number) height.
	* @param    p  (Object) containing properties of graphic element.
	*/	
	public function draw(t:MovieClip, w:Number, h:Number, p:Object):Void {
		setSize( t, w, h, p );		
	}
	
	public function setState(t:MovieClip, _state:String ):Void {
		if( t.back_mc ) {
			t.back_mc.gotoAndStop(_state);		
		} else t.gotoAndStop(_state);	
	}
	
	public function setSize( t:MovieClip, w:Number, h:Number, p ) {
		
		if( t.back_mc != undefined ) t = t.back_mc;
		
		var width:Number = w - ( t.l._width + t.r._width );
		var height:Number = h - ( t.t._height + t.b._height );		

		if( t.tl ) {
			t.l._x = t.bl._x = t.tl._x = t.tl._y = t.t._y = t.tr._y = 0;
			
			t.t._width = t.c._width = t.b._width = width;
			t.l._height = t.c._height = t.r._height = height;
			
			t.r._x = t.br._x = t.tr._x = t.l._width  + width;
			t.b._y = t.br._y = t.bl._y = t.t._height + height;
			
			t.c._x = t.tl._width;
			t.c._y = t.tl._height;
		
		}
		else
		if( t.t ) {
			t.c._x = t.b._x = t.t._x = t.t._y = 0;
			t.c._height = height;
			t.c._y = t.t._height;
			t.b._y = t.t._height + height; 
		}
		else
		if( t.l ) {
			t.l._x = t.l._y = t.c._y = t.r._y = 0;
			t.c._width = width;
			t.c._x = t.l._width;
			t.r._x = t.l._width + width; 
		}
		else if( t._name == "back_mc" ) {
			t._width = w;
			t._height = h;
		}

	}
	
	private function UISprite() {

	}
	
	// privates
	private static var _oI:UISprite;
}