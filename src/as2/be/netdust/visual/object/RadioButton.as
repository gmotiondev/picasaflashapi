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
import be.netdust.visual.object.Button;
class be.netdust.visual.object.RadioButton
extends Button
{
	public var styleClass:String = "RadioButton";
	
	public function set selected( _bSel:Boolean )
	{
		_select= _bSel;	
		if( selected ) _onStateHandler( "select" );
		else _onStateHandler( "deselect" );
	};
	
	
	public function get selected( ):Boolean 
	{
		return _select; 
	};
	
	public function RadioButton( _sValue:String, _styleID ) {
		super( _sValue, _styleID );		
	}
	
	public function paint()
	{		
		super.paint();	
		
		_skin.draw( bullet, bulletdeselectstyle.width, bulletdeselectstyle.height, bulletdeselectstyle );	
		_skin.draw( bullet.select, bulletselectstyle.width, bulletselectstyle.height, bulletselectstyle );	
		
		_skin.draw( ui, width, height, getStyle() );		
	}
	
	public function doLayout() {
		
		_labeltf.text = getLabel();
		_labeltf.autoSize = "left";	
		_labeltf.selectable = false;	

		bullet._x = getStyle().paddingLeft;
		bullet._y = height/2 - bulletdeselectstyle.height/2;
		
		_labeltf._x = bulletdeselectstyle.width + getStyle().paddingLeft*2;
		_labeltf._y = getStyle().paddingTop;
		
		width = _labeltf._x + _labeltf._width + getStyle().paddingRight;
		height =  getStyle().paddingTop + _labeltf._height + getStyle().paddingBottom;
		
		bullet.select._x = bulletdeselectstyle.width/2 - bulletselectstyle.width/2;
		bullet.select._y = bulletdeselectstyle.height/2 - bulletselectstyle.height/2;
		
		if( selected ) _onStateHandler( "release" );
		
	}
	
	private function _onStateHandler( _state:String )
	{
		bullet.select._visible = selected;
		super._onStateHandler( _state );
		
		if( _state == "release"  ) {
			selected = true;
		}
		else if( _state == "select" ) {
			_skin.setState( ui, "selected", getStyle() );
		}
	};
	
	private function setup()
	{
		super.setup();
		
		if( ui.bullet != undefined ) bullet = ui.bullet
		else
		{
			bullet = ui.createEmptyMovieClip( "bullet", 2 );
			var bulletselect:MovieClip = bullet.createEmptyMovieClip( "select", 1 );
			bulletselect._visible = false;
		};
	}
	
	private function init() {
		super.init()
		_select = false;
		
		bulletdeselectstyle = getStyle().getSubStyle("radiobullet");
		
		bulletdeselectstyle.cornerBottomRight = bulletdeselectstyle.width/2;
		bulletdeselectstyle.cornerBottomLeft = bulletdeselectstyle.width/2;
		bulletdeselectstyle.cornerTopLeft = bulletdeselectstyle.width/2;
		bulletdeselectstyle.cornerTopRight = bulletdeselectstyle.width/2;
		
		bulletselectstyle = bulletdeselectstyle.getSubStyle("select");

		bulletselectstyle.cornerBottomRight = bulletselectstyle.width/2;
		bulletselectstyle.cornerBottomLeft = bulletselectstyle.width/2;
		bulletselectstyle.cornerTopLeft = bulletselectstyle.width/2;
		bulletselectstyle.cornerTopRight = bulletselectstyle.width/2;
	};
	
	
	private var bulletdeselectstyle:Style = null;
	private var bulletselectstyle:Style = null;

	private var bullet:MovieClip = null;
	private var _select:Boolean;
}