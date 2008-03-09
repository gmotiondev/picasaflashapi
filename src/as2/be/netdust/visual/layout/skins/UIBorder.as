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

 /* use this class for dynamic component drawing */
 
import be.netdust.visual.tools.Rectangle;
import be.netdust.visual.layout.styles.Style;
import be.netdust.visual.layout.skins.ISkin;
import be.netdust.visual.layout.skins.AbstractSkin;

/* todo: better border handling */

class be.netdust.visual.layout.skins.UIBorder 
extends AbstractSkin
{

	/**
	* @method      UIBorder.getInstance
	* @description Singleton access to UIBorder class.
	* @usage       <code> UIBorder.getInstance():Void;</code> 
	*/
	public static function getInstance():ISkin {
		if( _oI==null) _oI = new UIBorder();
		return _oI;
	}
	
	/**
	* @method      UIBorder.init
	* @description creates a movieclip container to hold the ui.
	* @usage       <code> UIBorder.init( container:MovieClip, depth:Number, instanceid:String ) : MovieClip;</code> 
	* @return	   the container movieclip
	*/
	public function init( container:MovieClip, depth:Number, instanceid:String ) : MovieClip 
	{
		var ui:MovieClip = container.createEmptyMovieClip( instanceid+"_"+depth, depth );
		return ui;
	}
	
	/**
	* @method      UIBorder.setState
	* @description draws the state of a uiobject
	* @usage       <code> UIBorder.setState(t:MovieClip, _state:String,  p:Object ) : Void;</code> 
	* @return	   the container movieclip
	*/
	public function setState(t:MovieClip, _state:String,  p:Style ) : Void 
	{
		var _style = p.getSubStyle(_state)!=undefined ? p.getSubStyle(_state) : p;
		draw(t, p.width, p.height, _style);
		
		if( t.label != undefined ) {
			var fs:String = "";
	
			switch( _state ) {
				case "disabled": fs = "df"; break;				
				default: fs = "fu"; break;
			}

			if( _style.getFormat(fs) ) t.label.setTextFormat( _style.getFormat(fs) );
			else t.label.setTextFormat( _style.getFormat("fu") );
		}
	}
	
	/**
	* @method      UIBorder.draw
	* @description Draws skins.
	* @usage       <code>UIBorder.draw(t:MovieClip, w:Number, h:Number, p:Style):Void;</code> 
	*
	* @param    t  (MovieClip) movie clip for drawing.
	* @param    w  (Number) width.
	* @param    h  (Number) height.
	* @param    p  (Style) containing properties of graphic element.
	*/	
	public function draw(t:MovieClip, w:Number, h:Number, p:Style):Void
	{
		// mg
		var borderType:String

		t.clear();
				
		if ( p.borderStyle == "groove" || p.borderStyle == "ridge" ) {
			borderType = "3DBorderBox";				
		} else {
			borderType = "BorderBox";
		}			
		
		var corner:Object = { br:p.cornerBottomRight,
							  bl:p.cornerBottomLeft,
							  tl:p.cornerTopLeft,
							  tr:p.cornerTopRight
							}; 
							
		var border:Object = { bottom: { color:p.borderBottomColor, alpha:p.borderBottomAlpha , thick:p.borderBottomWidth }, 
							  top: { color:p.borderTopColor, alpha:p.borderTopAlpha , thick:p.borderTopWidth }, 
							  left: { color:p.borderLeftColor, alpha:p.borderLeftAlpha , thick:p.borderLeftWidth }, 
							  right: { color:p.borderRightColor, alpha:p.borderRightAlpha , thick:p.borderRightWidth } 
							}; 
							
		w -= Math.round( p.hborder/2 );
		h -= Math.round( p.vborder/2 );
		
		switch ( borderType ) {
			case "3DBorderBox":
				//Rectangle.draw(t, 0, 0, w, h, p.border.corner, p.border.color, 100, 90, "linear");
				//Rectangle.draw(t, p.border.thick, p.border.thick, w-p.border.thick*2, h-p.border.thick*2, p.corner, p.color, 100, 90, "linear");
				break;
				
			case "BorderBox":
				Rectangle.draw(t, Math.round( p.borderLeftWidth/2 ) + p.backgroundPosition.x, Math.round( p.borderTopWidth/2 ) + p.backgroundPosition.y, p.backgroundPosition.x + w, p.backgroundPosition.y+h, corner, p.backgroundColor, p.backgroundAlpha, 90, "linear", null, border);
				break;

			default: 			
				Rectangle.draw(t, 0, 0, w, h, corner, p.backgroundColor, p.backgroundAlpha, 90, "linear");
				break;
		}

	}

	private function UIBorder() {

	}
	
	// privates
	private static var _oI:UIBorder;
}