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
import be.netdust.visual.object.Button;

class be.netdust.visual.object.PushButton extends Button
{
	
	public var styleClass:String = "PushButton";	

	public function PushButton( _sIcon:String, _styleID ) 
	{
		super( null, _styleID );
	}
	
	public function doLayout() 
	{
		//
	}

	private function _onStateHandler( _state:String ) 
	{
		super._onStateHandler(_state);
		
		if( _state == "press" ) pushInterval();
		if( _state == "release" || _state == "releaseout" ) killInterval();
	}
	
	private function killInterval()   
	{
        clearInterval(intID);
        intID = null;
    } 
	
	private function onPush()
	{
		callObserver( "onPushInterval" );
	}
	
    private function pushInterval() 
	{
        if (intID == null)
        intID = setInterval(this, "onPush", 10);
		
        killInterval();
        intID = setInterval(this, "onPush", 60);
    } 
	
	private var _focusInstance:Boolean = false;
	private var intID:Number = null;
}