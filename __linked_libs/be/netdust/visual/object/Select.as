import com.bourre.events.IEvent;

import be.netdust.visual.object.Menu;
import be.netdust.visual.object.MenuItem;
class be.netdust.visual.object.Select
extends Menu
{
	
	public var styleClass:String = "Select";

	public function Select( _sValue:String, _styleID ) {
		super( _sValue, _styleID );
	};
	
	public function getLabel() : String
	{
		return currentItem.getLabel();
	}

	public function getMenuPosition(  )
	{
		var p:Object = {x:ui._parent._x, y:ui._parent._y }
		ui.localToGlobal( p );	

		_menupopup.setPosition( p.x, p.y  - ( (currentItem.y-currentItem.height) +(_menupopup.getStyle().vpadding ) ) );
	};
	
	public function getMenuOption( index:Number ) : MenuItem
	{
		return MenuItem(_menupopup.getChild( index ));
	}
	
	public function doLayout():Void 
	{
		currentItem = getMenuOption( 0 );
		super.doLayout();		
	}
	
	
	private function onClick( e:IEvent )
	{
		if( currentItem != e.getTarget() ) 
		currentItem = e.getTarget();	
		
		_menupopup.hide();
		_labeltf.text = getLabel();		
		dispatchEvent( ON_CLICK_EVENT );
				
	};
}