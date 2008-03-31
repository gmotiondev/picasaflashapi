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
import be.netdust.visual.layout.skins.ISkin;
class be.netdust.visual.layout.skins.AbstractSkin 
implements ISkin
{

	public function init( t:MovieClip, d:Number, i:String  ) : MovieClip {
		// ABSTRACT FUNCTION;
		return null;
	}
	
	/**
	* @method      AbstractSkin.draw
	* @description Draws skins.
	* @usage       <code>AbstractSkin.draw(t:MovieClip, w:Number, h:Number, p:Object):Void;</code> 
	*
	* @param    t  (MovieClip) movie clip for drawing.
	* @param    w  (Number) width.
	* @param    h  (Number) height.
	* @param    p  (Object) containing properties of graphic element.
	*/	
	public function draw(t:MovieClip, w:Number, h:Number, p:Object):Void {
		// ABSTRACT FUNCTION;
	}
	
	public function setState(t:MovieClip, _state:String ):Void {
		// ABSTRACT FUNCTION;
	}
	
	/**
	* private constructor
	*/
	private function AbstractSkin() {
	}
}